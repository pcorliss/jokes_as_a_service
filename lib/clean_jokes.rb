require 'redd'

class CleanJokes
  def get_joke
    joke = jokes.shift
    {
      title: joke.title,
      punchline: joke.selftext
    }
  end

  private

  def jokes
    @jokes ||= client.get_top('cleanjokes', :limit => 10).sort_by { rand }
  end

  def client
    @client ||= Redd::Client::Unauthenticated.new
  end
end
