# == Class redis::config
# This class is meant to be called from redis
# it bakes the configuration file
# === Parameters
#
# [*options*]
#   A hash of extra options to set in the configuration
#
# === Example
#
#  class { redis:
#    options => {
#      'key1' => 'value1',
#      'key2' => 'value2',
#    }
#  }
define redis::instance::config(
    $port = undef,
    $configfile = "/etc/redis${name}.conf",
    $pidfile = "/var/run/redis/redis${name}.pid",
    $logfile = "/var/log/redis/redis${name}.log",
    $dbfilename = "dump${name}.rdb",
    $var_dir = "/var/lib/redis${name}",
    $vm_swap_file = "/tmp/redis${name}.swap",
    $bind_address = false,
    $timeout = 0,  # 0 = disabled
    $loglevel = 'notice',
    ) {
  include redis::params
  file { $configfile:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    content => template('redis/redis.conf.erb')
  }
  file { "/etc/init.d/redis${name}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('redis/redis.init.erb'),
  }
}
