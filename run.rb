require 'lib/consumer.rb'
require 'lib/producer.rb'

zk = if ENV.has_key?('ZK_ADDRESS')
       ENV['ZK_ADDRESS']
     else
       "localhost:2181"
     end


if ARGV.empty?
  $stderr.puts "Commands:\n-c Run a consumer\n-p Run a producer"
end

command = ARGV.shift

if command == "-p"
  $stdout.puts "starting producer..."
  producer = Producer.new(zk, "ping")
  producer.run!
elsif command == "-c"
  $stdout.puts "starting consumer..."
  consumer = Consumer.new(zk,"ping")
  consumer.run!
end
