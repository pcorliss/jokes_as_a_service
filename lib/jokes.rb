require 'redd'

class Jokes
  def get_joke(joke_type = nil)
    joke_type ||= 'cleanjokes'
    joke = jokes(joke_type).shift
    {
      title: joke.title,
      punchline: joke.selftext
    }
  end

  private

  def jokes(joke_type)
    @jokes ||= {}
    if @jokes[joke_type].nil? || @jokes[joke_type].none?
      @jokes[joke_type] = client.get_top(joke_type).sort_by { rand }
    end
    @jokes[joke_type]
  end

  def client
    @client ||= Redd::Client::Unauthenticated.new
  end
end
