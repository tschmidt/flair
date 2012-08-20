$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "flair/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "flair"
  s.version     = Flair::VERSION
  s.authors     = ["Terry Schmidt"]
  s.email       = ["terry.m.schmidt@gmail.com"]
  s.homepage    = "https://github.com/tschmidt/flair"
  s.summary     = "Easily add a styleguide to your rails app."
  s.description = s.summary

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "kss", "~> 0.4.0"
  s.add_dependency 'sass-rails', '~> 3.1'
  s.add_dependency "rails", "~> 3.2"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end
