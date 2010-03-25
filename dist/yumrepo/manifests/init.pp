# Class: yumrepo
#
# This class installs and configures a local Yum repo
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class yumrepo {
  include apache

  file { "/opt/repository/yum":
    ensure => directory,
  }

  file { [ "/opt/repository/yum/base", "/opt/repository/yum/updates" ]:
    ensure => directory,
    require => File["/opt/repository/apt"],
  }

  apache::vhost { "yum.puppetlabs.com": 
    priority => '20',
    port => "80",
    docroot => "/opt/repository/yum",
  }
}

