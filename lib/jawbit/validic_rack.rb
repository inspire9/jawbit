class Jawbit::ValidicRack
  delegate :instrument, to: ActiveSupport::Notifications

  def call(env)
    request = Rack::Request.new env

    instrument 'notification.validic', json: json(request)

    [200, {}, ['']]
  end

  private

  def json(request)
    MultiJson.load request.body.read
  end
end
