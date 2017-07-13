FROM fmer/rails:latest

COPY . /usr/src
RUN \
  # install and snapshot production deps
  bin/bundle install --deployment --without development test assets && \
  cp -r /usr/local/bundle /usr/local/bundle_prod && \
  cp -r /usr/src /usr/src_prod && \

  # install all deps
  bin/bundle config --delete without && \
  bin/bundle install --deployment && \

  # run tests
  bin/rails test && \

  # compile assets
  DATABASE_URL=${DATABASE_URL:-mysql2://stub:stub@mysql/stub} bin/rails assets:precompile


FROM ruby:2.4-alpine
ENV RAILS_ENV=production

RUN \
  apk --update add tzdata mariadb-dev

WORKDIR /usr/src
COPY Gemfile* /usr/src/

# copy snapshoted production deps & assets
COPY --from=0 /usr/src_prod /usr/src
COPY --from=0 /usr/src/public/assets /usr/src/public/assets
COPY --from=0 /usr/local/bundle_prod /usr/local/bundle

RUN chown -R nobody:nogroup /usr/src /usr/local/bundle
USER nobody

EXPOSE 3000
CMD ["/usr/src/bin/rails", "s", "-b", "0.0.0.0"]
