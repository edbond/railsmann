# configure statsd host and port.
<%= Rails.application.class.to_s %>.configure do
  config.railsmann.enabled = true
  config.railsmann.host = '<%= options[:host] || 'localhost' %>'
  config.railsmann.port = <%= options[:port] || 5555 %>
end

