class DotsController < ApplicationController
  layout 'application'

  def index
    @dots = access_token.get("/api/v1/dots").parsed if access_token 
  end

end
