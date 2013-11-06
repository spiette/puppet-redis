# == Class: redis
#
# Install redis package. This is not meant to be called directly.
# The redis::instance define will activate the service
#
# === Authors
#
# Simon Piette <piette.simon@gmail.com>
#
# === Copyright
#
# Copyright 2013 Simon Piette
#
class redis () {
  include redis::install
}
