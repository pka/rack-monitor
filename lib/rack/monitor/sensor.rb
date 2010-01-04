require 'rack'

module Rack::Monitor

class Sensor
  #Called before request
  def before(env)
  end
  
  #Called after request
  def after(env, status, headers, body)
  end
  
  #Called before delivering measurements
  def collect
  end
  
  #Return measured values arrays [variable, description, value]
  def measurements
    []
  end
end

end