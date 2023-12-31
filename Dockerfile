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

RUN gem update --system 3.5.3

RUN gem install foreman

COPY Gemfile Gemfile.lock ./

RUN bundle check || bundle install

COPY . ./

ENTRYPOINT ["./docker/docker-entrypoint.sh"]

EXPOSE 3000

CMD [ "bundle", "exec", "puma", "-C", "config/puma.rb" ]