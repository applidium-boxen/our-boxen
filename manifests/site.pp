require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::homebrewdir}/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  include atom
  include chrome
  include dnsmasq
  include git
  include heroku
  include java
  include jumpcut
  #include mysql
  #include postgresql
  include sublime_text
  include sourcetree
  include zsh

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

    # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'gnu-tar'
    ]:
  }
  package { 'android-studio':
    provider => 'brewcask'
  }
  package { 'mac2imgur':
    provider => 'brewcask'
  }
  package { 'slack':
    provider => 'brewcask'
  }

  # default ruby versions
  ruby::version { '2.2.4': }
  ruby::version { '2.3.0': }

  ruby_gem { 'bundler for all ruby versions':
    gem => 'bundler',
    version => '~> 1.1',
    ruby_version => '*'
  }
  ruby_gem { 'cocoapods for 2.2.4':
    gem => 'cocoapods',
    version => '~> 0.39.0',
    ruby_version => '2.2.4'
  }
  ruby_gem { 'cocoapods for 2.3.0':
    gem => 'cocoapods',
    version => '~> 0.39.0',
    ruby_version => '2.3.0'
  }


  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }
}
