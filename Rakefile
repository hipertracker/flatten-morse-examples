require 'rake/testtask'

Rake::TestTask.new do |task|
  task.libs << %w(src test)
  task.pattern = 'test/test_*.rb'
end

task :default => :test