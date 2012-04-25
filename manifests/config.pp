class ruby::config {

  # Install a custom /etc/gemrc file. The source of the file is defined
  #  in ruby::params. This is only needed if RubyGems will need to install
  #  gems from somewhere other than rubygems.org
  file { "/etc/gemrc":
    source  => $ruby::params::gemrc_src,
    require => Class['ruby::install'],
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  # Set up the PATH, globally, so that the custom Ruby in /opt/ruby will
  #  come first. This just satisfies the devs' constant nagging about
  #  needing to specify the full path to Ruby on the dev machines. Doesn't
  #  harm progs like puppet or facter, which specify (via hashbang) which
  #  Ruby they want to use, which is the system one at /usr/bin/ruby
  file { '/etc/profile.d/rubypath.sh':
    content => "#!/bin/bash\nexport PATH=/opt/ruby/bin:\$PATH\n",
    mode    => '0755',
  }

}
