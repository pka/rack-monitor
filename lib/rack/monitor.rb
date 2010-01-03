require "rack"

module Rack::Monitor
  autoload :MonitorApp,                'rack/monitor/monitor_app'

  def self.new(*args, &block)
    MonitorApp.new(*args, &block)
  end

end