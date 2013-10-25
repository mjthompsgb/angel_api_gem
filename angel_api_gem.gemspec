$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "angel_api_gem/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "angel_api_gem"
  s.version     = AngelApiGem::VERSION
  s.authors     = ["Matt Thompson"]
  s.email       = ["mjthompsgb@gmail.com"]
  s.homepage    = "http://angelapi.matthewt.me"
  s.summary     = "Wrapper for AngelList API"
  s.description = "This gem will make it easy for you to get any data you need from the AngeList API."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
end
