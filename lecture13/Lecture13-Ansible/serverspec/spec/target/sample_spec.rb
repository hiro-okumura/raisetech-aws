require 'spec_helper'

listen_port = 80

describe command('git --version') do
    its(:stdout) { should match /git version 2\.47\.1/ }
end

describe command('node --version') do
    let(:disable_sudo) { true }
    its(:stdout) { should match /17\.9\.1/ }
end

describe command('yarn --version') do
    let(:disable_sudo) { true }
    its(:stdout) { should match /^1\.22\.19/ }
end

describe command('/home/ec2-user/.rbenv/shims/ruby -v') do
    its(:stdout) { should match /3\.2\.3/ }
end

describe package('mysql-community-server') do
    it { should be_installed }
end

describe service('puma') do
    it { should be_running }
end

describe service('nginx') do
    it { should be_running }
end

describe port(80) do
    it { should be_listening }
end

describe command('curl http://127.0.0.1:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
    its(:stdout) { should match /^200$/ }
end

