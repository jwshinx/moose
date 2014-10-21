require File.expand_path('lib/omniauth/strategies/tiber', Rails.root)
OmniAuth.config.logger = Rails.logger
puts '---> omniauth initializer'
Rails.logger.debug '---> omniauth initializer'

Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :tiber, ENV['TIBER_KEY'], ENV['TIBER_SECRET']
end
