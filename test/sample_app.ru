use Rack::ShowExceptions
use Rack::Lint
require "rack/contrib"

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require "rack/monitor"

use Rack::Access, '/rack_status' => [ '127.0.0.1' ]
use Rack::Monitor, :url => '/rack_status', :watch => ['/', '/ping'], :ignore_addr => []

run lambda {|env| [200, { 'Content-Type' => 'text/plain', 'Content-Length' => '12' }, ["Hello World!"] ] }
