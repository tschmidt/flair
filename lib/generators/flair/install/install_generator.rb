require 'rails'

module Flair
  class InstallGenerator < ::Rails::Generators::Base
    
    desc "Install the necessary files and routes for use with Flair"
    
    class_option :examples, :type => :boolean, :default => false,
                 :desc => "Adds files that demonstrate how to set up your styleguides."
    
    source_root File.expand_path('../templates', __FILE__)
    
    def install_steps
      add_structure
      add_examples if options.examples?
      mount_engine
    end

private

    def add_structure
      empty_directory 'app/views/flair/styleguides/'
    end
    
    def add_examples
      copy_file 'flair-buttons.css', 'app/assets/stylesheets/flair-buttons.css'
      copy_file 'buttons.html.erb', 'app/views/flair/styleguides/buttons.html.erb'
      copy_file '_navigation.html.erb', 'app/views/flair/styleguides/_navigation.html.erb'
    end
    
    def mount_engine
      route 'mount Flair::Engine => "/flair" if Rails.env.development?'
    end
    
  end
end