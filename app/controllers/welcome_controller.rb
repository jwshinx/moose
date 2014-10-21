class WelcomeController < ApplicationController
  layout 'application'

  def index
  end
  def failure
    @params = params
  end
  def callback
  end
end
