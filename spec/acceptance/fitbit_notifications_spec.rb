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

  def multipart_update(string)
    tempfile = Tempfile.new 'updates'
    tempfile.write string
    tempfile.rewind

    Rack::Test::UploadedFile.new(tempfile.path, 'application/json')
  end

  after :each do
    subscriptions.each do |subscription|
      ActiveSupport::Notifications.unsubscribe(subscription)
    end
  end

  it 'returns a 204' do
    post '/', updates: multipart_update('[]')

    expect(last_response.status).to eq(204)
  end

  it 'fires an event' do
    notification = false
    subscribe { |*args| notification = true }

    post '/', updates: multipart_update('[]')

    expect(notification).to eq(true)
  end

  it 'includes the JSON body' do
    subscribe { |*args|
      event = ActiveSupport::Notifications::Event.new *args
      expect(event.payload[:json]).to eq([{'foo' => 'bar'}])
    }

    post '/', updates: multipart_update('[{"foo":"bar"}]')
  end
end
