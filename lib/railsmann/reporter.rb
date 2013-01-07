require "riemann/client"

module Railsmann
  class NullReporter
    def report!(args)
      puts "#{args[0]}: #{args[2]-args[1]}"
      puts "--------------\n#{args.inspect}\n-----------\n"
    end
  end

  class Reporter
    def initialize(host, port)
      # note: multi threading depends on Statsd's capability for
      # protecting its socket.
      @client = Riemann::Client.new( host: host, port: port )
    end
    def report!(args)
      delta = args[2] - args[1]
      delta = (delta > 0) ? delta : 0
      @client << { service: args[0].to_s, metric: delta }
    end
  end
end
