require 'clean_jokes'

describe CleanJokes do
  let(:clean_jokes) { CleanJokes.new }

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
      joke = clean_jokes.get_joke
      expect(joke[:title]).to eq("Fake Joke")
      expect(joke[:punchline]).to eq("Fake Punchline")
    end
  end
end
