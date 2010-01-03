use Rack::ShowExceptions
use Rack::Lint

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require "rack/monitor"

use Rack::Monitor

run lambda {|env| [200, { 'Content-Type' => 'text/plain', 'Content-Length' => '12' }, ["Hello World!"] ] }
