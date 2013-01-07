$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "railsmann/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "railsmann"
  s.version     = Railsmann::VERSION
  s.authors     = ["Aadi Deshpande"]
  s.email       = ["aadi.deshpande@gmail.com"]
  s.homepage    = "http://blog.adarbitrium.com"
  s.summary     = "A Rails 3 gem to push ActiveSupport::Notification data to a reimann.server"
  s.description = "Cribbed from jondot/vitals, railsmann is a Rails 3 gem to push ActiveSupport::Notification data to a reimann.server"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0"
  s.add_dependency "riemann-client"
end
