# == Class: galaxy
#
# Full description of class galaxy here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { galaxy:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class galaxy (
	$galaxy_bitbucket_link = 'https://bitbucket.org/galaxy/galaxy-dist',
	$galaxy_install_dir = '/opt/galaxy-dist'
) {

package { "python":
	ensure => installed,
}

package { "mercurial":
	ensure => installed,
}

file {"/opt/galaxy-dist/universe_wsgi.ini":
  ensure  => present,
  content => template("galaxy/universe_wsgi.ini.erb"),
  mode    => '644'
}

vcsrepo { $galaxy_install_dir:
    ensure   => present,
    provider => hg,
    source   => $galaxy_bitbucket_link,
    require  => Package['mercurial']
}

user { 'galaxy':
  ensure           => 'present',
  comment          => 'galaxy',
}

}
