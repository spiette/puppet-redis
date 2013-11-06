# == Define redis::instance
define redis::instance (
  $port = undef,
  $configfile = "/etc/redis${name}.conf",
  $pidfile = "/var/run/redis/redis${name}.pid",
  $logfile = "/var/log/redis/redis${name}.log",
  $db_filename = "dump${name}.rdb",
  $var_dir = "/var/lib/redis${name}",
  $vm_swapfile = "/tmp/redis${name}.swap",
  $bind_address = false,
  $timeout = 0,  # 0 = disabled
  $loglevel = 'notice',
) {
  # 1) $port is defined
  # 2) no redis_port defined
  # 2a) $name is_integer     => 6379+ $name
  # 2b) $name is not integer => 6379
  if defined($port) {
    $redis_port = $port
  } else {
    if is_integer($name) {
      $redis_port = 6379 + $name
    } else {
      $redis_port = 6379
    }
  }

  include redis

  Class['redis'] ->
  Redis::Instance::Config[$name] ~>
  Redis::Instance::Service[$name]

  redis::instance::config { $name:
    port         => $redis_port,
    bind_address => $bind_address,
    configfile   => $configfile,
    pidfile      => $pidfile,
    logfile      => $logfile,
    db_filename  => $db_filename,
    var_dir      => $var_dir,
    vm_swapfile  => $vm_swapfile,
    timeout      => $timeout,
    loglevel     => $loglevel,
  }

  redis::instance::service { $name:
    pidfile => $pidfile,
  }
}
