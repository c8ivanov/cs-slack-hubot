FROM node:latest

MAINTAINER Arseniy Ivanov

RUN apt-get -q update && apt-get -qy install redis-server

RUN adduser --disabled-password --gecos "" hubot; \
  echo "hubot ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME /home/hubot
USER hubot
WORKDIR /home/hubot

COPY package.json ./

RUN npm install

COPY . ./

ENTRYPOINT ["./bin/hubot", "--adapter", "slack"]
