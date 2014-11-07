require 'jokes'

describe Jokes do
  let(:jokes) { Jokes.new }

  before do
    @post = double(
      Redd::Object::Submission,
      title: 'Fake Joke',
      selftext: 'Fake Punchline'
    )
    @client = double(
      Redd::Client::Unauthenticated,
      get_top: [@post]
    )
    allow(Redd::Client::Unauthenticated).to receive(:new).and_return(@client)
  end

  context "#get_joke" do
    it "return a hash with a title and a punchline" do
      joke = jokes.get_joke
      expect(joke[:title]).to eq("Fake Joke")
      expect(joke[:punchline]).to eq("Fake Punchline")
    end

    it "takes a type parameter to differentiate the joke" do
      expect(@client).to receive(:get_top).with('dadjokes').and_return([@post])
      jokes.get_joke('dadjokes')
    end

    it "gets more jokes when it runs out" do
      joke = jokes.get_joke
      @post = double(
        Redd::Object::Submission,
        title: 'Fake Joke 2',
        selftext: 'Fake Punchline'
      )
      expect(@client).to receive(:get_top).and_return([@post])
      joke = jokes.get_joke
      expect(joke[:title]).to eq('Fake Joke 2')
    end
  end
end
