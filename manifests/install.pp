class ruby::install ( $version='1.8.7' ) {
  # Make sure we're including the ruby class, so the 'params' and 'config'
  #  classes get tossed in our catalog
  include ruby

  # Install the packages. The ruby_packages variable gets defined in
  #  ruby::params, based on what version ruby::install was called with
  package { $ruby::params::ruby_packages:
    ensure  => present,
    require => Class['yum::inhouse'],

    # I use a 'before', here, instead of a require in the ruby_utf8 file,
    #  because from that file resource, we can't determine which package
    #  is actually setting up /opt/ruby
    before  => File['/opt/ruby/bin/ruby_utf8'],
  }

  # This file is a wrapper for for the ruby binary to get around some UTF8
  #  issues we've had. It explicitly sets all of the locale-related env vars
  #  so we don't have to worry about what the systems' settings are
  file { '/opt/ruby/bin/ruby_utf8':
    content => '#!/bin/bash
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
exec /opt/ruby/bin/ruby "$@"',
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
  }
}
