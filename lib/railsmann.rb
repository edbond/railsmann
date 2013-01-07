require 'active_support/notifications'
require 'vitals/reporter'

module Railsmann
  class Engine < Rails::Engine
    config.railsmann = ActiveSupport::OrderedOptions.new

    config.railsmann.enabled = true
    config.railsmann.host = 'localhost'
    config.railsmann.port = 5555

    initializer "railsmann.configure" do |app|
      Railsmann.configure(app.config.railsmann.host, app.config.railsmann.port) if app.config.railsmann.enabled
    end

    initializer "railsmann.subscribe" do |app|
      ActiveSupport::Notifications.subscribe( /[^!]$/ ) do |*args|
        Railsmann.report! args 
      end
    end
  end


  @reporter = NullReporter.new

  def self.report!(args)
    @reporter.report!(args)
  end

  def self.configure(host, port)
    @reporter = Reporter.new(host, port)
  end
end