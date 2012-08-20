module Flair
  module StyleguideHelper
    
    def link_to_styleguide(label, url)
      link_to label, url, :class => ('active' if params[:id] == url.split('/').last)
    end
    
    # Generates a styleguide block. A little bit evil with @_out_buf, but
    # if you're using something like Rails, you can write a much cleaner helper
    # very easily.
    def styleguide_block(section, &block)
      @section = styleguide.section(section)
      @content = capture(&block)
      render 'flair/styleguides/styleguide_block'
    end
    
private
    
    def styleguide
      @styleguide ||= Kss::Parser.new(File.expand_path('app/assets/stylesheets', Rails.root))
    end
    
  end
end
