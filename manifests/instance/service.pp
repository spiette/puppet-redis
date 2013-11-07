# == Class redis::service
# This class is meant to be called from redis
# It ensure the service is running
define redis::instance::service ($pidfile) {
  include redis::params
  service { "redis${name}":
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }
}
