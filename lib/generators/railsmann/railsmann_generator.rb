class VitalsGenerator < Rails::Generators::Base


  class_option :host,  :desc => "host ip or name"
  class_option :port, :desc => "statsd host port"

  source_root File.expand_path('../templates', __FILE__)

  def create_initializer
    template "railsmann_initializer.rb", "config/initializers/railsmann_initializer.rb"
  end
end
