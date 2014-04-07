class Jawbit::FitbitRack
  delegate :instrument, to: ActiveSupport::Notifications

  def initialize(subscriber_id, consumer_secret)
    @subscriber_id, @consumer_secret = subscriber_id, consumer_secret
  end

  def call(env)
    request = Rack::Request.new env

    instrument 'notification.fitbit', json: json(request)

    [204, {}, ['']]
  end

  private

  attr_reader :subscriber_id, :consumer_secret

  def json(request)
    MultiJson.load request.params['updates']
  end
end
