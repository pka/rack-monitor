module Rack::Monitor

class Version < Sensor
  def measurements
    m = [['rack_info', 'Rack version', Rack.release]]
    if defined?(Rails) && defined?(Rails::Info)
      m << ['rails_info', 'Rails version', Rails.version]
    end
    m
  end
end


end