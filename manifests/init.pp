# See README.md for more details.
class phantomjs (
  String $version = '2.1.1',
  Optional[String] $source_url = undef,
  Stdlib::Absolutepath $path = '/usr/local/bin/phantomjs',
) {

  case $::osfamily {
    'RedHat': {
      ensure_packages(['bzip2', 'fontconfig'])
    }
    default: {
      # Do nothing
    }
  }

  $source = pick($source_url, "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${version}-linux-x86_64.tar.bz2")

  archive { '/tmp/phantomjs.tar.bz2':
    source       => $source,
    extract      => true,
    extract_path => '/usr/local/src',
    creates      => "/usr/local/src/phantomjs-${version}-linux-x86_64",
    cleanup      => true,
    user         => 'root',
    group        => 'root',
  }
  -> file { 'phantomjs':
    ensure => 'file',
    path   => $path,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "/usr/local/src/phantomjs-${version}-linux-x86_64/bin/phantomjs"
  }

}
