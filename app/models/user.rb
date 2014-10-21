class User < ActiveRecord::Base
  class << self
    def from_omniauth(auth)
      Rails.logger.info "---> USER 1: #{auth.inspect}"
      where(provider: auth.provider, uid: auth.uid).first || create_from_omniauth(auth)
      #User.first
    end
    def create_from_omniauth(auth)
      create! do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
      end
    end
  end
end
