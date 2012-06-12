# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "deardevice/version"

Gem::Specification.new do |s|
  s.name        = "deardevice"
  s.version     = Deardevice::VERSION
  s.authors     = ["Gert Joergensen"]
  s.email       = ["gert@hvadhedderde.com"]
  s.homepage    = "http://dearapi.com"
  s.summary     = %q{Client library for DearAPI Devices API}
  s.description = %q{Ruby client library for the DearAPI Devices API - making browser segmentation easy. Read more at http://dearapi.com}

  s.rubyforge_project = "deardevice"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  # Needed for tests
  #s.add_development_dependency('rspec', '~> 2.4')
  #s.add_development_dependency('webmock', '~> 1.6')
  #s.add_development_dependency('bluecloth', '~> 2.0.11')
  
  # Needed to run
  s.add_runtime_dependency('faraday')
  s.add_runtime_dependency('faraday_middleware')
  s.add_runtime_dependency('multi_xml')
  s.add_runtime_dependency('hashie')
end
