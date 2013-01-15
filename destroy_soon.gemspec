# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "destroy_soon/version"

Gem::Specification.new do |s|
  s.name        = "destroy_soon"
  s.version     = DestroySoon::VERSION
  s.authors     = ["Guilherme Cavalcanti"]
  s.email       = ["guiocavalcanti@gmail.com"]
  s.homepage    = "http://github.com/redu/destroy-soon"
  s.summary     = "Delayed destroy ActiveRecord model using DelayedJob as queue system"
  s.description = "Delayed destroy ActiveRecord model"
  s.rubyforge_project = "destroy_soon"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.test_files    = Dir.glob('spec/**/*')
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "delayed_job_active_record", "~> 0.3.2"

  s.add_runtime_dependency "activerecord", "~> 3.0.19"
  s.add_runtime_dependency "activesupport", "~> 3.0.19"
  s.add_runtime_dependency "rake"
end
