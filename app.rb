require 'sinatra'
require './lib/clean_jokes'

get '/joke.json' do
  @clean_jokes ||= CleanJokes.new
  @clean_jokes.get_joke.to_json
end
