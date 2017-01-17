FROM johnwilliams/rpi-ruby:16.04

RUN apt-get update && apt-get install -y libmysqlclient-dev mysql-client

ENV APP_HOME /app
ENV HOME /root
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY . $APP_HOME

# Start server
ENV PORT 3000
EXPOSE 3000
CMD ["bin/bundle", "exec", "puma"]
