class virtual::groups {
	@group {'allstaff':
    ensure => present,
    gid    => 600,
	}
  @group {'sysadmin':
    ensure => present,
    gid    => 666,
  }
  @group {'developers':
    ensure => present,
    gid    => 667,
  }
  @group {'prosvc':
    ensure => present,
    gid    => 668,
  }
	@group {'operations':
		ensure => present,
		gid    => 673,
  }
	@group {'git':
		ensure => present,
		gid    => 674,
	}

#
# Service Groups
#
  @group {'hudson':
    ensure => present,
    gid    => 620,
  }
  @group {'osqa':
    ensure => present,
    gid    => 621,
  }
  @group {'patchwork':
    ensure => present,
    gid    => 622,
  }
}

