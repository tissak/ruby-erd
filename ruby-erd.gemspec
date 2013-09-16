# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "ruby-erd"
  s.version     = "0.0.1"
  s.authors     = ["Jordan Maguire"]
  s.email       = ["jmaguire@thefrontiergroup.com.au"]
  s.homepage    = "https://github.com/jordanmaguire/ruby-erd"
  s.summary     = "summary"
  s.description = "description"

  s.files         = Dir["lib/**/*.rb"]
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'ruby-graphviz'
end
