require 'spec_helper'

describe 'Fitbit Subscriptions' do
  include Rack::Test::Methods

  let(:app)             {
    FitbitSubscriptions::Rack.new subscription_id, consumer_secret
  }
  let(:subscription_id) { 'sub' }
  let(:consumer_secret) { '12345678901234567890123456789012' }

  it 'returns a 204' do
    post '/'

    expect(last_response.status).to eq(204)
  end
end
