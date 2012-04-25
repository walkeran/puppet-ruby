# Install RubyGems and keep it up to date via gem (pretty meta, eh?!)
define ruby::rubygems( $version ) {
  # Again, just make sure everything related to the ruby module gets included
  include ruby

  # Use ruby::gem::install to manage the rubygems-update package
  ruby::gem::install { 'rubygems-update':
    version => $version,
    notify  => Exec['ruby-gem-update_rubygems'],
  }

  # Once the gem is installed, fire off 'update_rubygems' which will do the
  #  dirty work (setup.rb, etc)
  exec { 'ruby-gem-update_rubygems':
    command => '/opt/ruby/bin/update_rubygems --no-ri --no-rdoc',
    refreshonly => true,
  }
}
