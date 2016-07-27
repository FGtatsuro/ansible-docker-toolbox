require "spec_helper_#{ENV['SPEC_TARGET_BACKEND']}"
require "brewcask_patch"

describe package('dockertoolbox'), :if => os[:family] == 'darwin' do
  it { should be_installed.by('homebrew_cask') }
end

describe command('which docker') do
  its(:exit_status) { should eq 0 }
end

describe command('which docker-machine') do
  its(:exit_status) { should eq 0 }
end

describe command('which docker-compose') do
  its(:exit_status) { should eq 0 }
end

describe file('/etc/systemd/system/docker.service.d'), :if => ['debian', 'ubuntu'].include?(os[:family]) do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/systemd/system/docker.service.d/docker.conf'), :if => ['debian', 'ubuntu'].include?(os[:family]) do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should include('[Service]') }
  its(:content) { should include("ExecStart=\n") }
  its(:content) { should include('ExecStart=/usr/bin/docker daemon -H fd:// --insecure-registry 192.168.1.1 --insecure-registry 192.168.1.2') }
end

describe file('/etc/default/docker'), :if => ['debian', 'ubuntu'].include?(os[:family]) do
  it { should be_file }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  its(:content) { should include('DOCKER_OPTS="-H fd:// --insecure-registry 192.168.1.1 --insecure-registry 192.168.1.2"') }
end
