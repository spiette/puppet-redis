# == Class redis::intall
# This class is meant to be called from redis. It installs required packages
# and a default logrotate file.
class redis::install {
  include redis::params
  package { $redis::params::pkgname:
    ensure => present,
  }
  file { '/etc/logrotate.d/redis':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    source  => 'puppet:///modules/redis/redis.logrotate',
    require => Package[$redis::params::pkgname],
  }
}
