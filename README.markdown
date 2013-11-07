# redis::instance

[![Build Status](https://travis-ci.org/spiette/puppet-redis.png?branch=master)](https://travis-ci.org/spiette/puppet-redis)

This is the redis module. It is meant to manage many instances of redis on a
single server, so all you CPU cores can contribute to the task. It doesn't use
defaults configuration file and paths, but rather use it's own for each
instance.

# CAUTION

Not thoroughly tested yet.

# Requirements

* puppetlabs/stdlib

# Installation

  puppet module install spiette/redis

# Synopsis

    redis::instance { '1':
      loglevel => 'verbose',
    }

This will create a configuration file /etc/redis1.conf with the following settings:

    port = 6379 + $name  # if $name is an integer
    configfile = "/etc/redis${name}.conf",
    pidfile = "/var/run/redis/redis${name}.pid",
    logfile = "/var/log/redis/redis${name}.log",
    dbfilename = "dump${name}.rdb",
    dir = "/var/lib/redis${name}",
    vm-swap-file = "/tmp/redis${name}.swap",
    bind = undefined
    timeout = 0,  # 0 = disabled
    loglevel = 'verbose',

You can quickly create 3 redis instances with:

    redis::instance { [ '1', '2', '3' ]: }

# Parameters

Most parameters match the corresponding redis setting.

- *port*
- *configfile*
- *pidfile*
- *logfile*
- *db_filename*
- *var_dir*
- *vm_swap_file*
- *bind_address*
- *timeout*
- *loglevel*

# License

  See LICENSE

# Contact

Simon Piette <piette.simon@gmail.com>

# Support

Please log tickets and issues at the [project site](https://github.com/spiette/puppet-redis)

# Thanks

Big thanks to Matheus Pacheco <matheus.pacheco@tritondigital.com>, who provided the templates and the first draft of the module.
