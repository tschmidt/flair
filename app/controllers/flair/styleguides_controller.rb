require_dependency "flair/application_controller"

module Flair
  class StyleguidesController < ApplicationController
    def index
    end
  
    def show
      render params[:id]
    end
  end
end
