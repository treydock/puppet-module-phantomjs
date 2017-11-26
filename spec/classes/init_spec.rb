require 'spec_helper'

describe 'phantomjs' do
  on_supported_os({
    :supported_os => [
      {
        "operatingsystem" => "RedHat",
        "operatingsystemrelease" => ["6", "7"],
      }
    ]
  }).each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/dne',
        })
      end

      case facts[:osfamily]
      when 'RedHat'
        bzip_package = 'bzip2'
        fontconfig_package = 'fontconfig'
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to create_class('phantomjs') }
      it { is_expected.to contain_package(bzip_package)}
      it { is_expected.to contain_package(fontconfig_package)}

      it do
        is_expected.to contain_archive('/tmp/phantomjs.tar.bz2').only_with(
          :source       => "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2",
          :extract      => 'true',
          :extract_path => '/usr/local/src',
          :creates      => "/usr/local/src/phantomjs-2.1.1-linux-x86_64",
          :cleanup      => 'true',
          :user         => 'root',
          :group        => 'root',
          :before       => ['File[phantomjs]'],
        )
      end
      it do
        is_expected.to contain_file('phantomjs').only_with(
          :ensure => 'file',
          :path   => '/usr/local/bin/phantomjs',
          :owner  => 'root',
          :group  => 'root',
          :mode   => '0755',
          :source => "/usr/local/src/phantomjs-2.1.1-linux-x86_64/bin/phantomjs"
        )
      end
      

    end # end context
  end # end on_supported_os loop
end # end describe
