require 'rake/testtask'

task :gem => :gemspec do
  sh 'gem build em-spec.gemspec'
end

task :gemspec do
  
end

task :install => :gem do
  sh 'sudo gem install em-spec-*.gem'
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