require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rake'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec

desc 'Run statistical tests'
task :stats do
  load 'extra/stats.rb'
end

desc 'Build examples for README'
task :readme do
  load 'extra/readme.rb'
end
