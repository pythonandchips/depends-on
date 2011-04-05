# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "depends_on/version"

Gem::Specification.new do |s|
  s.name        = "depends_on"
  s.version     = DependsOn::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Colin Gemmell"]
  s.email       = ["pythonandchips{at}gmail.com"]
  s.homepage    = "http://pythonandchips.net"
  s.summary     = %q{Simple dependency injection for ruby}
  s.description = %q{Simple dependency injection for ruby}

  s.rubyforge_project = "depends_on"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
