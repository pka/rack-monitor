module Rack::Monitor

class Request < Sensor
  def initialize
    @count = 0
  end
  
  def after(env)
    @count += 1
  end
  
  def measurements
    [['count', 'Total requests', @count]]
  end
end

end