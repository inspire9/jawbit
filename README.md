# Jawbit

For receiving Fitbit, Jawbone and/or Validic subscription requests in a Rails (or Rack) app.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jawbit', '0.1.0'
```

## Usage

```ruby
# in config/routes.rb
post '/fitbit/subscriptions', to: Jawbit::FitbitRack.new(
  subscriber_id, consumer_secret
)
post '/jawbone/subscriptions', to: Jawbit::JawboneRack.new
post '/validic/subscriptions', to: Jawbit::ValidicRack.new

# in an initialiser:
ActiveSupport::Notifications.subscribe('notification.fitbit') do |*args|
  event = ActiveSupport::Notifications::Event.new *args
  # use event.payload[:json] however you like.
end

ActiveSupport::Notifications.subscribe('notification.jawbone') do |*args|
  event = ActiveSupport::Notifications::Event.new *args
  # use event.payload[:json] however you like.
end

ActiveSupport::Notifications.subscribe('notification.validic') do |*args|
  event = ActiveSupport::Notifications::Event.new *args
  # use event.payload[:json] however you like.
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/jawbit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Licence

Copyright (c) 2014, Jawbit is developed and maintained by [Inspire9](http://development.inspire9.com), and is released under the open MIT Licence.
