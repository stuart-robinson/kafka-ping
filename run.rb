require 'lib/consumer.rb'
require 'lib/producer.rb'

zk = if ENV.has_key?('ZK_ADDRESS')
       ENV['ZK_ADDRESS']
     else
       "localhost:2181"
     end

command = ARGV.shift

if command == "-p"
  producer = Producer.new(zk, "ping")
  producer.run!
else
  consumer = Consumer.new(zk,"ping")
  consumer.run!
end
