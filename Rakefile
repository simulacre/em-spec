require 'rake/testtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "em-spec"
    s.description = s.summary = "Simple BDD API for testing asynchronous Ruby/EventMachine code"
    s.email = "aman@tmm1.net"
    s.homepage = "http://github.com/joshbuddy/em-spec"
    s.authors = ["Aman Gupta"]
    s.files = FileList["[A-Z]*", "{lib,test}/**/*"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

task :default => :spec

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test_spec.rb']
  t.verbose = true
end

task :spec do
  sh('rake test') rescue nil
  sh('bacon test/bacon_spec.rb') rescue nil
  sh 'spec -f specdoc test/rspec_spec.rb test/rspec_fail_examples.rb'
end