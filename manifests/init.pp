# == Class: phpmemcacheadmin
#
# This class installs the webgrind package along with the necessary configuration
# files and a virtual host for accessing the output.
#
# === Examples
#
#   class { 'phpmemcacheadmin': }
#
# === Requirements
#
class phpmemcacheadmin() {
  exec { 'exec mkdir -p /usr/share/php/phpmemcacheadmin/source':
    command => "mkdir -p /usr/share/php/phpmemcacheadmin/source",
    creates => '/usr/share/php/phpmemcacheadmin/source',
  }

  exec { 'php-download-phpmemcacheadmin':
    cwd     => '/tmp',
    command => 'wget http://phpmemcacheadmin.googlecode.com/files/phpMemcachedAdmin-1.2.2-r262.zip',
    creates => "/usr/share/php/phpmemcacheadmin/source/index.php",
  }

  exec { 'php-extract-phpmemcacheadmin':
    cwd     => '/tmp',
    command => 'unzip phpMemcachedAdmin-1.2.2-r262.zip -d phpmemcacheadmin',
    creates => "/usr/share/php/phpmemcacheadmin/source/index.php",
    require => Exec['php-download-phpmemcacheadmin'],
  }

  exec { 'php-move-phpmemcacheadmin':
    command => "cp -r /tmp/phpmemcacheadmin/* /usr/share/php/phpmemcacheadmin/source",
    creates => "/usr/share/php/phpmemcacheadmin/source/index.php",
    require => [ Exec['php-extract-phpmemcacheadmin'], Exec['exec mkdir -p /usr/share/php/phpmemcacheadmin/source'] ],
  }
}
