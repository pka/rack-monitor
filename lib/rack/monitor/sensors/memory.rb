module Rack::Monitor

class Memory < Sensor
  def initialize
    @used = 0
  end
  
  def collect
    @used = `ps -o rss= -p #{$$}`.to_i
  end
  
  def measurements
    [['used', 'Memory used', @used]]
  end
end


end