require 'rake'
require 'rspec/core/rake_task'

task :spec    => 'spec:all'
task :default => :spec

namespace :spec do
  hosts = [
    {
      :name     =>  'localhost',
      :backend  =>  'exec',
      :group_append_user  =>  'travis'
    },
    {
      :name     =>  'container',
      :backend  =>  'docker'
    },
    {
      :name     =>  'vagrant_debian',
      :backend  =>  'vagrant'
    },
    {
      :name     =>  'vagrant_ubuntu',
      :backend  =>  'vagrant'
    },
    {
      :name     =>  'vagrant_centos',
      :backend  =>  'vagrant'
    }
  ]
  if ENV['SPEC_TARGET'] then
    target = hosts.select{|h|  h[:name] == ENV['SPEC_TARGET']}
    hosts = target unless target.empty?
  end

  task :all     => hosts.map{|h|  "spec:#{h[:name]}"}
  task :default => :all

  hosts.each do |host|
    desc "Run serverspec tests to #{host[:name]}(backend=#{host[:backend]})"
    RSpec::Core::RakeTask.new(host[:name].to_sym) do |t|
      ENV['TARGET_HOST'] = host[:name]
      ENV['SPEC_TARGET_BACKEND'] = host[:backend]
      ENV['GROUP_APPEND_USER'] = host[:group_append_user]
      t.pattern = "spec/docker_toolbox_spec.rb"
    end
  end
end
