module Api
  module V1
    class DriveSessionsController < ApplicationController
      respond_to :json

      def index
        respond_with DriveSession.all
      end
    end
  end
end
