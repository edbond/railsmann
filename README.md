# Railsmann

Railsmann is a very simple rails 3 plugin which exposes [`ActiveSupport::Notification`](http://api.rubyonrails.org/classes/ActiveSupport/Notifications.html)s
back to [`riemann`](http://riemann.io).  

Railsmann is cribbed nearly verbatim from another great gem,
[`Vitals`](http://github.com/jondot/vitals)

## Getting Started

Add `railsmann` to your `Gemfile`. Then, run:

    $ bundle install

### Configuration

If you're not running `statsd` at the default configuration (localhost/8125), you can generate
an initializer:

    $ rails g railsmann
or  
    
    $ rails g railsmann --host=<YOURHOST> --port=<PORT>
    







