# Use ruby::gem::install to install the passenger gem. This class is only here
#  to make use of the default gem version defined in common::params (which is,
#  admittedly, a really stupid place to define it). Also, it makes it easy to
#  "require => Class['ruby::gem_passenger']" in resources that need this gem
class ruby::gem_passenger( $version=$common::params::def_gem_passenger ) {
  ruby::gem::install{ 'passenger':
    version => $version,
  }
}
