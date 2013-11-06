# == Class redis::params
# This class is meant to be called from redis
# It set variable according to platform
class redis::params {
  $pkgname = 'redis'
  $conffile = 'redis/etc/redis.conf'
  $service = $::osfamily ? {
    'Debian' => 'redis',
    'RedHat' => 'redis',
    default  => fail('unsupported platform')
  }
}
