require "bundler/gem_tasks"
require "rspec/core/rake_task"

namespace :spec do
  Dir["./spec/*_spec.rb"].each do |file|
    task_name = File.basename(file, "_spec.rb")
    RSpec::Core::RakeTask.new(task_name) do |task|
      task.pattern = file
    end
  end
end

task default: "spec:medium"
