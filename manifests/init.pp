# Simply include the params, install, and config sub-clases. I honestly
#  don't remember why I used 'require' here, instead of 'include'
class ruby ( $version='1.8.7' ) {
  include ruby::params, ruby::install, ruby::config
}
