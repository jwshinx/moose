class DotsController < ApplicationController
  layout 'application'

  def index
    @oc = oauth_client
    @at = access_token
    @dots = access_token.get("/api/v1/dots").parsed if access_token 
    # @dots = @json.map{|dot| JSON.parse(dot) }
  end

end
