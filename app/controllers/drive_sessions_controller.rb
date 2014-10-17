class DriveSessionsController < ApplicationController
  layout 'application'

  def index
    @dss = DriveSession.all.to_a
  end
end
