require 'jruby-kafka'

class Consumer

  def initialize(zk, topic)

    @consumer_options = {
      :topic_id => topic,
      :zk_connect => zk,
      :group_id => "my_consumer_group",
      :auto_offset_reset => "smallest",
      :auto_commit_interval => 50
    }

  end

  def run!

    count = 0
    consumer_group = Kafka::Group.new(@consumer_options)
    queue = SizedQueue.new(20)
    consumer_group.run(1,queue)

    trap('SIGINT') do
      consumer_group.shutdown()
      exit
    end

    loop do
      if !queue.empty?
        $stdout.puts "#{count}\t#{queue.pop.message.to_s}"
        count += 1
      end
    end
  end
end
