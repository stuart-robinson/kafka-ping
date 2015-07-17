require 'jruby-kafka'

consumer_options = {
  :topic_id => "test_topic",
  :zk_connect => "localhost:2181",
  :group_id => "my_consumer_group",
  :auto_offset_reset => "smallest",
  :auto_commit_interval => 50
}

consumer_group = Kafka::Group.new(consumer_options)
queue = SizedQueue.new(20)
consumer_group.run(1,queue)

count = 0

trap('SIGINT') do
  consumer_group.shutdown()
  puts "Consumed #{count} messages"
  exit
end

loop do
  if !queue.empty?
    count += 1
  end
end
