module Rack::Monitor

class Request < Sensor
  STATUS_CODES = [200, 403, 404]
  def initialize
    @count = 0
    @status = {}
    (STATUS_CODES+[1,2,3,4,5]).each { |code| @status[code] = 0 }
  end
  
  def after(env, status, headers, body)
    @count += 1
    @status[code_group(status)] += 1
  end
  
  def measurements
    m = [['count', 'Total requests', @count]]
    STATUS_CODES.each do |status|
      m << ["status#{status}", "Responses with status #{status}", @status[status]]
    end
    [1,2,3,4,5].each do |status|
      m << ["status#{status}", "Responses with other status #{status}xx", @status[status]]
    end
    m
  end

  private

  def code_group(code)
    if STATUS_CODES.include?(code)
      code
    else
      code / 100
    end
  end
end

end