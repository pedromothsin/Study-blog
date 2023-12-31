#!/bin/sh

# if database exists, run migrations, otherwise setup db and run migrations
bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:create db:migrate

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

./bin/dev
