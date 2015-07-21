FROM quay.io/fundingcircle/alpine-java
RUN apk update && apk add bash openssl
RUN wget http://s3.amazonaws.com/jruby.org/downloads/1.7.21/jruby-bin-1.7.21.tar.gz
RUN tar -xzf jruby-bin-1.7.21.tar.gz
RUN wget https://github.com/stuart-robinson/kafka-ping/archive/master.zip
RUN unzip master.zip
ENV JAVA_HOME=/jre \
    PATH=$PATH:/jruby-1.7.21/bin
RUN gem install bundler jruby-kafka
RUN cd /kafka-ping-master && bundle install
WORKDIR /kafka-ping-master
ENTRYPOINT envconsul -consul consul.service.consul:8500 -prefix zk/config
CMD jruby run.rb -c


