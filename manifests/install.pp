# == Class redis::intall
# This class is meant to be called from redis
# It install requires packages
class redis::install {
  include redis::params
  package { $redis::params::pkgname:
    ensure => present,
  }
}
