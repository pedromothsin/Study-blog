FROM ruby:3.2.2-alpine

ENV BUNDLER_VERSION=2.5.3

RUN apk add --update --no-cache \
    binutils-gold \
    build-base \
    curl \
    file \
    g++ \
    gcc \
    git \
    less \
    libstdc++ \
    libffi-dev \
    libc-dev \ 
    linux-headers \
    libxml2-dev \
    libxslt-dev \
    libgcrypt-dev \
    make \
    netcat-openbsd \
    openssl \
    pkgconfig \
    postgresql-dev \
    tzdata

RUN gem install bundler -v 2.5.3

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle check || bundle install

# RUN chmod +x ./docker/docker-entrypoint.sh
# RUN chmod +x ./docker/sidekiq-entrypoint.sh
# RUN chmod +x ./bin/*

COPY . ./

ENTRYPOINT ["./docker/docker-entrypoint.sh"]