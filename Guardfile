guard 'bundler' do
  watch(/^Gemfile/)
  watch(/^.+\.gemspec/)
end

guard 'rspec', :version => 2 do
  watch(/^spec\/.*_spec\.rb/)
  watch(/^lib\/(.*)\.rb/)
end
