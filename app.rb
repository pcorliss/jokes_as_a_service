require 'sinatra'
require './lib/jokes'

get '/joke.json' do
  @@jokes ||= Jokes.new
  @@jokes.get_joke(params[:type]).to_hash.merge(obj_id: @jokes.object_id).to_json
end
