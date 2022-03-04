FROM ruby:3.0.0

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client npm
RUN npm i -g yarn && yarn

RUN mkdir /new_app
WORKDIR /new_app
COPY Gemfile /new_app/Gemfile
COPY Gemfile.lock /new_app/Gemfile.lock
RUN bundle install
COPY . /new_app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

