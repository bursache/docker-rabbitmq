#!/bin/bash

docker build -t docker-rabbitmq . && docker run -d -p 5671:5671 -p 5672:5672 -p 61613:61613 -p 61614:61614 -p 15671:15671 -p 15672:15672 docker-rabbitmq