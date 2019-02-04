require "spec_helper_#{ENV['SPEC_TARGET_BACKEND']}"
require "brewcask_patch"

describe command('which docker') do
  its(:exit_status) { should eq 0 }
end

describe file('/etc/group'), :if => ENV['GROUP_APPEND_USER'] && ['debian', 'ubuntu'].include?(os[:family]) do
  its(:content) { should match /docker:x:\d*:#{ENV['GROUP_APPEND_USER']}/ }
end

describe package('docker-toolbox'), :if => os[:family] == 'darwin' do
  it { should be_installed.by('homebrew_cask') }
end

# On CentOS7, /etc/default/docker doesn't exist.
describe file('/etc/default/docker'), :if => ['debian', 'ubuntu'].include?(os[:family]) do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should include('DOCKER_OPTS="') }
  its(:content) { should include('--insecure-registry 192.168.1.1:5000 --insecure-registry 192.168.1.2:5000"') }
end

# Linux Common
if os[:family] != 'darwin'
  property[:os] = nil
  set :os, :family => 'linux'
end

describe file('/etc/systemd/system/docker.service.d'), :if => os[:family] == 'linux' do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/systemd/system/docker.service.d/docker.conf'), :if => os[:family] == 'linux' do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should include('[Service]') }
  its(:content) { should include("ExecStart=\n") }
  its(:content) { should include("ExecStart=/usr/bin/dockerd") }
  its(:content) { should include('--insecure-registry 192.168.1.1:5000 --insecure-registry 192.168.1.2:5000') }
end

