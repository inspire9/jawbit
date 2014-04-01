# coding: utf-8
Gem::Specification.new do |spec|
  spec.name          = 'fitbit_subscriptions'
  spec.version       = '0.0.1'
  spec.authors       = ['Pat Allan']
  spec.email         = ['pat@freelancing-gods.com']
  spec.summary       = %q{Captures Fitbit subscription notifications.}
  spec.description   = <<-DESC
Handle Fitbit subscription notifications within a Rails or Rack app, and pass
them on via ActiveSupport::Notifications.
  DESC
  spec.homepage      = 'https://github.com/inspire9/fitbit_subscriptions'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split('\x0')
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rack'
end
