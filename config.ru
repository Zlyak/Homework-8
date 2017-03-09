require 'lib/geeks'


use Rack::Reloader, 0
use Rack::Static, :urls => ["/assets", "/images"], :root => "public"

run Geeks.new