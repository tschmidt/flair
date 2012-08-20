require 'rails'
require 'sass-rails'
require 'kss'

module Flair
  class Engine < ::Rails::Engine
    isolate_namespace Flair
  end
end
