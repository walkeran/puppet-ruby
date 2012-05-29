class ruby::params {
  # If, for whatever reason, the ruby class isn't yet in our catalog,
  #  do that NOW so the following conditionals can determine the
  #  ruby version that's being installed/configured
  require ruby

  # Define the source for the /etc/gemrc file based on the realm
  #  in which this server is homed
  $gemrc_src = $base::realm ? {
    'met'   => "puppet:///modules/ruby/gemrc-met",
    'aws'   => "puppet:///modules/ruby/gemrc-aws",
    default => "puppet:///modules/ruby/gemrc",
  }

  # Set ruby_version for use inside this class to determine packages. This is
  #  probably not needed, as ruby::version should always be set
  if $ruby::version {
    $ruby_version = $ruby::version
  } else {
    $ruby_version = '1.8.7'
  }

  # Figure out what Ruby packages need to be installed based on the Ruby
  #  that we want
  $ruby_packages = $ruby_version ? {
    '1.8.7'   => [ 'ruby-enterprise-fbs', 'rubygems-fbs' ],
    '1.9.2'   => [ 'ruby19-fbs', 'ruby19-fbs-libs', 'ruby19-fbs-devel' ],
  }

  # Define the libcompat_version variable which is needed in a few places to
  #  determine the absolute path to a gem (ie: when setting up the passenger
  #  module in Apache
  $libcompat_version = $ruby_version ? {
    '1.8.7'   => '1.8',
    '1.9.2'   => '1.9.1',
  }
}
