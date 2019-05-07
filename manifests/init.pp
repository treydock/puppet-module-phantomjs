# @summary Install and configure phantomjs
#
# @example Install PhantomJS 2.1.1 to /usr/local/bin/phantomjs
#   include ::phantomjs
#
# @example Install specific version of PhantomJS
#   class { 'phantomjs':
#      version => '1.9.8',
#    }
#
# @param version
#   Version of PhantomJS to install.
# @param source_url
#   Optional URL for PhantomJS download.
# @param path
#   The path to phantomjs binary.
#
class phantomjs (
  String $version = '2.1.1',
  Optional[String] $source_url = undef,
  Stdlib::Absolutepath $path = '/usr/local/bin/phantomjs',
  Array $package_dependencies = ['bzip2','fontconfig'],
) {

  $package_dependencies_defaults = {
    'before' => Archive['/tmp/phantomjs.tar.bz2']
  }
  ensure_packages($package_dependencies, $package_dependencies_defaults)

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
