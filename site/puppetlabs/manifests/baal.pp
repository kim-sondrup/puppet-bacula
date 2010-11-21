# Class: puppetlabs::baal
#
# This class installs and configures Baal
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppetlabs::baal {
  $mysql_root_pw = 'c@11-m3-m1st3r-p1t4ul'

  # Base
  include puppetlabs
  include account::master

  # Puppet modules
  $dashboard_site = 'dashboard.puppetlabs.com'
  include puppet::server
  include puppet::dashboard

  # Package management
  include aptrepo
  include yumrepo

  # Backup
  $bacula_password = 'pc08mK4Gi4ZqqE9JGa5eiOzFTDPsYseUG'
  $bacula_director = 'baal.puppetlabs.com'
  include bacula
  include bacula::director
  
  # Monitoring
  include nagios::server
  include nagios::webservices
  include nagios::dbservices
  include nagios::bacula
  nagios::website { 'apt.puppetlabs.com': }
  nagios::website { 'yum.puppetlabs.com': }
  nagios::website { 'nagios.puppetlabs.com': auth => 'monit:5kUg8uha', }
  nagios::website { 'dashboard.puppetlabs.com': auth => 'monit:5kUg8uha', }
  nagios::website { 'munin.puppetlabs.com': auth => 'monit:5kUg8uha', }
  nagios::website { 'visage.puppetlabs.com': auth => 'monit:5kUg8uha', }

  # Munin
  include munin
  include munin::server
  include munin::dbservices
  include munin::passenger
  include munin::puppet
  include munin::puppetmaster
 
  # Collectd
  include collectd::server

  # pDNS
  include pdns
  
  # Gitolite
  Account::User <| tag == 'git' |>

  apache::vhost {'mail.puppetlabs.com':
    port => 80,
    docroot => null,
    ssl => false,
    priority => 60,
    template => 'puppetlabs/redirection_vhost.conf.erb',
  }

}
