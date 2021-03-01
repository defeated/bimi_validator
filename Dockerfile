FROM ruby:2.7.2-alpine

RUN apk --update add --no-cache \
    build-base sqlite-dev tzdata git

RUN mkdir -p /app
WORKDIR /app
COPY gems/ ./gems/
COPY Gemfile* ./
RUN bundle

VOLUME /app
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
