# Install a gem. This class isn't very dynamic, as it has the ruby location
#  hard-coded. Works fine for our needs, though
define ruby::gem::install( $package=$name, $env="", $moreopts="", $version='UNSET', $logoutput=false ) {
  # Make sure we have the ruby class included so that ruby is installed
  #  and configured prior to trying to use it
  include ruby

  # If a version wasn't passed along (default is to set it to 'UNSET'), then
  #  we need the installation process to operate a little differently. These
  #  could be merged in the future, I just haven't bothered, as they work as-is
  if $version == 'UNSET' {

    # Use gem binary to install the package, and use "gem list" piped to grep
    #  to see if any version exists
    exec { "ruby-gem-install-${package}":
      command   => "/opt/ruby/bin/gem install --no-rdoc --no-ri ${moreopts} ${package}",
      unless    => "/opt/ruby/bin/gem list | /bin/grep ${package}",
      require   => Class['ruby::config'],
      logoutput => $logoutput,
    }

  } else {

    # Use gem binary to install the package, and use the ruby binary to include
    #  a specific gem version to see if that version exists
    exec { "ruby-gem-install-${package}":
      command   => "/opt/ruby/bin/gem install --no-rdoc --no-ri ${moreopts} --version '${version}' ${package}",
      unless    => "/opt/ruby/bin/ruby -rubygems -e \"gem '${package}', '${version}'\"",
      require   => Class['ruby::config'],
      logoutput => $logoutput,
    }

  }

  # If there needs to be any special environment vars passed for this gem's
  #  installation, tack that on here using the nifty "plusignment" operator
  if ($env) {
    Exec["ruby-gem-install-${package}"] {
      environment +> $env,
    }
  }
}
