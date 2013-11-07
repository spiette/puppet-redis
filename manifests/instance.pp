# == Define redis::instance
define redis::instance (
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
  # 1) $port is defined
  # 2) no redis_port defined
  # 2a) $name is_integer     => 6379+ $name
  # 2b) $name is not integer => 6379
  if ($port) {
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
    dbfilename   => $dbfilename,
    var_dir      => $var_dir,
    vm_swap_file => $vm_swap_file,
    timeout      => $timeout,
    loglevel     => $loglevel,
  }

  redis::instance::service { $name:
    pidfile => $pidfile,
  }
}
