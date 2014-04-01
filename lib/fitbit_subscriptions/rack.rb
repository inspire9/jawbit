class FitbitSubscriptions::Rack
  def initialize(subscriber_id, consumer_secret)
    @subscriber_id, @consumer_secret = subscriber_id, consumer_secret
  end

  def call(env)
    request = Rack::Request.new env

    [204, {}, ['']]
  end

  private

  attr_reader :subscriber_id, :consumer_secret
end
