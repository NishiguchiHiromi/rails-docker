FROM ruby:2.7.1

ENV LANG C.UTF-8

RUN mkdir -p /web
WORKDIR /web

RUN apt-get update && \
    apt-get install -y \
      npm \
      default-mysql-client \
      vim \
      unzip \
      imagemagick \
      --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash

RUN apt-get install nodejs -y
RUN npm install -g yarn

RUN gem install bundler
COPY Gemfile /web/Gemfile
COPY Gemfile.lock /web/Gemfile.lock
RUN bundle install
COPY . /web
