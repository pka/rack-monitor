require 'rack/monitor/sensor'

# Load all sensors
#
Dir[File.join(File.dirname(__FILE__), 'sensors', '*.rb')].each do |sensor|
  require sensor
end

module Rack::Monitor

class MonitorApp
  def initialize(app, options={})
    @app = app
    @options = {:url=>'/rack_status'}.merge(options)
    sensor_class_names = Rack::Monitor.constants.reject { |s| %q(Sensor MonitorApp).include?(s) }
    @sensors = sensor_class_names.collect { |s| Rack::Monitor.const_get(s).new }
  end

  def call(env, options={})
    if env["PATH_INFO"] == @options[:url]
      [200, {'Content-Type' => 'text/plain'}, [monitor_output]]
    else
      @sensors.each { |sensor| sensor.before(env) }
      status, headers, body = @app.call(env)
      @sensors.each { |sensor| sensor.after(env, status, headers, body) }
      [status, headers, body]
    end
  end

  private

  def monitor_output
    output = ''
    @sensors.each do |sensor|
      class_name = sensor.class.name.gsub(/^.*::/, '')
      sensor.collect
      sensor.measurements.each do |var, desc, value|
        output << "[#{class_name}:#{var}] #{desc}: #{value}\n"
      end
    end
    output
  end
end

end