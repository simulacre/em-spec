require 'rake/testtask'
require 'rubygems'
require 'bundler'
Bundler::GemHelper.install_tasks

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

