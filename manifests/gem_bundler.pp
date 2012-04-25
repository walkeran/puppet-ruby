# Use ruby::gem::install to install the bundler gem. This class is only here
#  to make use of the default gem version defined in common::params (which is,
#  admittedly, a really stupid place to define it)
class ruby::gem_bundler( $version=$common::params::def_gem_bundler ) {
  ruby::gem::install{ 'bundler':
    version => $version,
  }
}
