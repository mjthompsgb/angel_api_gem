require 'net/http'
require 'uri' 
require 'json'
require 'open-uri'

module AngelApiGem
  class Engine < ::Rails::Engine
    isolate_namespace AngelApiGem
  end
end
