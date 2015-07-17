require 'jruby-kafka'
require 'zk'
require 'json'


zk = ZK.new("localhost:2181")

broker_ids = zk.children('/brokers/ids')
broker_list = []
broker_ids.each do |id|
  broker_data = JSON.parse(zk.get("/brokers/ids/#{id}")[0])
  broker_list << "#{broker_data["host"]}:#{broker_data["port"]}"
end

puts broker_list.join(",")

producer_options = {:broker_list => broker_list.join(","), "serializer.class" => "kafka.serializer.StringEncoder"}

count = 0
producer = Kafka::Producer.new(producer_options)
producer.connect()

trap('SIGINT') do
  puts "produced #{count} messages"
  exit
end

while true do
  count += 1
  producer.send_msg("test_topic", nil, "ping")
end

