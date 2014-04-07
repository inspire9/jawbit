require 'spec_helper'

describe 'Jawbone Subscriptions' do
  include Rack::Test::Methods

  let(:app)           { Jawbit::JawboneRack.new }
  let(:subscriptions) { [] }

  def subscribe(&block)
    subscriptions << ActiveSupport::Notifications.subscribe(
      'notification.jawbone', &block
    )
  end

  after :each do
    subscriptions.each do |subscription|
      ActiveSupport::Notifications.unsubscribe(subscription)
    end
  end

  it 'returns a 200' do
    post '/', '[]'

    expect(last_response.status).to eq(200)
  end

  it 'fires an event' do
    notification = false
    subscribe { |*args| notification = true }

    post '/', '[]'

    expect(notification).to eq(true)
  end

  it 'includes the JSON body' do
    subscribe { |*args|
      event = ActiveSupport::Notifications::Event.new *args
      expect(event.payload[:json]).to eq([{'foo' => 'bar'}])
    }

    post '/', '[{"foo":"bar"}]'
  end
end
