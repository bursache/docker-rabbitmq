#
# RabbitMQ Dockerfile
#

# Pull base image.
FROM ubuntu:14.04

MAINTAINER Bogdan Ursache (bogdan.ursache@thinslices.com)

# Add files.
ADD rabbitmq_files/bin/rabbitmq-start /usr/local/bin/
ADD rabbitmq_files/rabbitmq.config /usr/local/bin/rabbitmq.config
ADD rabbitmq_files/rabbitmq-definitions.json /usr/local/bin/rabbitmq-definitions.json
COPY rabbitmq_files/certificates /usr/local/bin/certificates

# Install RabbitMQ.
RUN \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6B73A36E6026DFCA && \
  echo "deb http://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y rabbitmq-server pwgen && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  rabbitmq-plugins enable rabbitmq_management && \
  rabbitmq-plugins enable rabbitmq_web_stomp && \
  cp /usr/local/bin/rabbitmq.config /etc/rabbitmq/rabbitmq.config && \
  chmod +x /usr/local/bin/rabbitmq-start && \
  mkdir /data

# Define default command.
CMD ["rabbitmq-start"]

# Expose ports.
EXPOSE 5672
EXPOSE 5671
EXPOSE 61613
EXPOSE 61614
EXPOSE 15672
EXPOSE 15671