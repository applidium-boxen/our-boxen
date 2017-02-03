# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

# Shortcut for a module from GitHub's boxen organization
def github(name, *args)
  options ||= if args.last.is_a? Hash
    args.last
  else
    {}
  end

  if path = options.delete(:path)
    mod name, :path => path
  else
    version = args.first
    options[:repo] ||= "boxen/puppet-#{name}"
    mod name, version, :github_tarball => options[:repo]
  end
end

# Shortcut for a module under development
def dev(name, *args)
  mod "puppet-#{name}", :path => "#{ENV['HOME']}/src/boxen/puppet-#{name}"
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen", "3.11.1"

# Support for default hiera data in modules

github "module_data", "0.0.4", :repo => "ripienaar/puppet-module-data"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github "atom",        "1.3.0"
github "brewcask",    "0.0.7"
github "chrome",      "1.2.0"
github "dnsmasq",     "2.0.2"
github "foreman",     "1.2.0"
github "gcc",         "3.0.2"
github "git",         "2.11.0"
github "homebrew",    "2.1.0"
github "inifile",     "1.4.1", :repo => "puppetlabs/puppetlabs-inifile"
github "java",        "1.8.4"
github "jumpcut",     "1.0.0"
github "openssl",     "1.0.0"
github "osx",         "2.8.0"
github "pkgconfig",   "1.0.0"
github "repository",  "2.4.1"
github "ruby",        "8.5.5", :repo => "applidium-boxen/puppet-ruby"
github "stdlib",      "4.7.0", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",        "1.0.0"
github "xquartz",     "1.2.1"
github "sublime_text","1.1.0"
github "sourcetree",  "1.0.0"
github "zsh",         "1.0.0"

# github "elasticsearch", "2.8.0"
github "mysql",         "2.0.1"
github "postgresql",  "4.0.1"
# github "redis",       "3.1.0"
github "sysctl",      "1.0.1"
github "heroku",      "2.0.0"
