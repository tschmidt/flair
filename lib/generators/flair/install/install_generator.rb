require 'rails'

module Flair
  class InstallGenerator < ::Rails::Generators::Base
    
    desc "Install the necessary files and routes for use with Flair"
    
    def install_steps
      route 'mount Flair::Engine => "/flair" if Rails.env.development?'
    end
    
  end
end