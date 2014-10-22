class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(auth_hash)
    session[:user_id] = user.id
    session[:access_token] = auth_hash["credentials"]["token"]
    #self.current_user = @user
    redirect_to dots_url, notice: "Signed in."
  end

  def destroy
    session[:user_id] = nil
    #session[:access_token] = nil
    redirect_to root_url, notice: "Signed out."
  end

  #protected
  private

  def auth_hash
    # Rails.logger.info "---> sc 1: #{request.env['omniauth.auth']}"
    request.env['omniauth.auth']
  end
  #def permitted_auth_hash
  #  x = auth_hash.permit('provider', 'id', info_attributes: ['email'])
  #  Rails.logger.info "---> sc 2: #{x.inspect}" 
  #  x
  #end
end
