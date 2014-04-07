require 'spec_helper'

describe 'Fitbit Subscriptions' do
  include Rack::Test::Methods

  let(:app)             {
    Jawbit::FitbitRack.new subscription_id, consumer_secret
  }
  let(:subscription_id) { 'sub' }
  let(:consumer_secret) { '12345678901234567890123456789012' }
  let(:subscriptions)   { [] }

  def subscribe(&block)
    subscriptions << ActiveSupport::Notifications.subscribe(
      'notification.fitbit', &block
    )
  end

  after :each do
    subscriptions.each do |subscription|
      ActiveSupport::Notifications.unsubscribe(subscription)
    end
  end

  it 'returns a 204' do
    post '/'

    expect(last_response.status).to eq(204)
  end

  it 'fires an event' do
    notification = false
    subscribe { |*args| notification = true }

    post '/'

    expect(notification).to eq(true)
  end

  it 'includes the JSON body' do
    subscribe { |*args|
      event = ActiveSupport::Notifications::Event.new *args
      expect(event.payload[:json]).to eq([{'foo' => 'bar'}])
    }

    post '/', updates: '[{"foo":"bar"}]'
  end
end
