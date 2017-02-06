require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new(:spec) do |task|
  task.pattern = FileList['spec/**/*_spec.rb']
  task.verbose = false
end

task default: :spec
