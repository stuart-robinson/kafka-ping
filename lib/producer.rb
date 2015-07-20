require 'jruby-kafka'
require 'zk'
require 'json'

class Producer

  def initialize(zk, topic)
    @zk = zk
    @topic = topic
  end

  def fetch_brokers
    zk = ZK.new(@zk)

    broker_ids = zk.children('/brokers/ids')
    broker_list = []
    broker_ids.each do |id|
      broker_data = JSON.parse(zk.get("/brokers/ids/#{id}")[0])
      broker_list << "#{broker_data["host"]}:#{broker_data["port"]}"
    end
    broker_list
  end

  def run!

    kafka_connect = fetch_brokers.join(",")

    producer_options = {
      :broker_list => kafka_connect,
      "serializer.class" => "kafka.serializer.StringEncoder"
    }

    count = 0
    producer = Kafka::Producer.new(producer_options)
    producer.connect()

    trap('SIGINT') do
      $stdout.puts "produced #{count} messages"
      exit
    end

    while true do
      count += 1
      producer.send_msg(@topic, nil, "ping")
    end
  end
end

