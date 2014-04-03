class Jawbit::JawboneRack
  delegate :instrument, to: ActiveSupport::Notifications

  def call(env)
    request = Rack::Request.new env

    instrument 'notification.jawbone', json: json(request)

    [200, {}, ['']]
  end

  private

  def json(request)
    MultiJson.load request.body.read
  rescue MultiJson::ParseError
    []
  end
end
