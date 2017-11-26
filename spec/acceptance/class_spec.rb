require 'spec_helper_acceptance'

describe 'phantomjs class:' do
  context 'default parameters' do
    it 'should run successfully' do
      pp =<<-EOS
      class { 'phantomjs': version => '1.9.8' }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file('/usr/local/bin/phantomjs') do
      it { should be_file }
      it { should be_mode 755 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end

    describe command('/usr/local/bin/phantomjs --version') do
      its(:stdout) { should match /1.9.8/ }
    end
  end

  context 'upgrades phantomjs' do
    it 'should run successfully' do
      pp =<<-EOS
      class { 'phantomjs': version => '2.1.1' }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file('/usr/local/bin/phantomjs') do
      it { should be_file }
      it { should be_mode 755 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end

    describe command('/usr/local/bin/phantomjs --version') do
      its(:stdout) { should match /2.1.1/ }
    end
  end
end
