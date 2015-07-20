FROM quay.io/fundingcircle/alpine-java
RUN apk update && apk add bash openssl
RUN wget http://s3.amazonaws.com/jruby.org/downloads/1.7.21/jruby-bin-1.7.21.tar.gz
RUN tar -xzf jruby-bin-1.7.21.tar.gz
RUN wget https://github.com/stuart-robinson/kafka-ping/archive/master.zip
RUN unzip master.zip
