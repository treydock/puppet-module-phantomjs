require 'spec_helper_acceptance'

describe 'phantomjs class:' do
  context 'default parameters' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'phantomjs': version => '1.9.8' }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe file('/usr/local/bin/phantomjs') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 755 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
    end

    describe command('/usr/local/bin/phantomjs --version') do
      its(:stdout) { is_expected.to match %r{1.9.8} }
    end
  end

  context 'upgrades phantomjs' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'phantomjs': version => '2.1.1' }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe file('/usr/local/bin/phantomjs') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 755 }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
    end

    describe command('/usr/local/bin/phantomjs --version') do
      its(:stdout) { is_expected.to match %r{2.1.1} }
    end
  end
end
