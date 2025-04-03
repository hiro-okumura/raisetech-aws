"sample_spec.rb" 39L, 774B                                                  21,0-1        All
require 'spec_helper'

listen_port = 80
listen_port = 22

describe command('ruby -v') do
    its(:stdout) { should match 'ruby 3.2.3' }
end

describe command('bundler -v') do
    its(:stdout) { should match 'Bundler version 2.4.19' }
end

describe command('yarn -v') do
    its(:stdout) { should match '1.22.19' }
end

describe package('nginx') do
    it { should be_installed }
end

describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
end

describe service('puma') do
    it { should be_enabled }
    it { should be_running }
end

describe port(listen_port) do
    it { should be_listening }
end

describe command('curl http://127.0.0.1:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
    its(:stdout) { should match /^200$/ }
end