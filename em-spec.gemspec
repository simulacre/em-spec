# -*- encoding: utf-8 -*-

require File.join(File.dirname(__FILE__), 'lib', 'em-spec', 'version')

Gem::Specification.new do |s|
  s.name = 'em-spec'
  s.version = EventMachine::Spec::VERSION
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aman Gupta"]
  s.summary = "Simple BDD API for testing asynchronous Ruby/EventMachine code"
  s.description = "Simple BDD API for testing asynchronous Ruby/EventMachine code"
  s.email = %q{aman@tmm1.net}
  s.extra_rdoc_files = ['README.rdoc']
  s.files = `git ls-files`.split("\n")
  s.homepage = %q{http://github.com/joshbuddy/em-spec}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.test_files = `git ls-files`.split("\n").select{|f| f =~ /^test/}
  s.rubyforge_project = 'em-spec'

  # dependencies
  s.add_development_dependency 'bundler', ">= 1.0.0"

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

