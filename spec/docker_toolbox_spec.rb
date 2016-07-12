require "spec_helper_#{ENV['SPEC_TARGET_BACKEND']}"
require "brewcask_patch"

describe package('docker'), :if => os[:family] == 'darwin' do
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
