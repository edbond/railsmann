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
    def report! args
      tag, t1, t2, uid, options = args
      more = case tag
             when "sql.active_record"
               { description: options[:sql] }
             when "render_partial.action_view"
               { description: options[:identifier] }
             when "render_template.action_view"
               { description: options[:identifier] }
             when "!render_template.action_view"
               { description: options[:virtual_path] }
             when "process_action.action_controller"
               # {:controller=>"Users::WatchlistsController",
               # :action=>"index", :params=>{"action"=>"index",
               # "controller"=>"users/watchlists"}, :format=>:html,
               # :method=>"GET", :path=>"/users/watchlists",
               # :status=>200, :view_runtime=>3189.5200240000013,
               # :db_runtime=>9506.09494, :query_runtime=>0}
               p = options[:params].symbolize_keys
               t = [p[:controller].gsub("/",'.'), p[:action]].
                 join('.')

               # POST view and DB runtime
               @client << {
                           service: "#{t}.sql",
                           metric: p[:db_runtime],
                          }

               @client << {
                           service: "#{t}.view",
                           metric: p[:view_runtime],
                          }

               if options[:status] && options[:status] >= 400
                 @client << {
                             service: "#{t}.error",
                             metric: p[:view_runtime],
                            }
               end

               { description: "complete #{options[:path]} #{options[:format]}",
                   service: t, }
             when "start_processing.action_controller"
               p = options[:params].symbolize_keys
               t = [p[:controller].gsub("/",'.'), p[:action]].
                 join('.')
               { description: "start #{options[:path]} #{options[:format]}",
                   service: t, }
             else
               Rails.logger.info "[instrumentation]: not handled tag! #{tag}"
               Rails.logger.debug "[instrumentation]: #{args.inspect}"
               { description: options.values.first }
             end
      metric = (t2 - t1) * 1000.0 # in msec
      metric = [metric, 0].max
      @client << { service: tag.to_s,
                  metric: metric }.merge(more)
    end
  end
end
