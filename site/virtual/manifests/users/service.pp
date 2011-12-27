class virtual::users::service {

  include virtual::groups

  ### Service Accounts ###
  # UID range 22000-22999
  #

  @account::user { 'deploy':
    uid     => 22000,
    comment => 'Deployment User',
    group   => www-data,
    groups  => ["enterprise"], # 11435
    tag     => deploy,
    usekey  => "false",
  }
  # 11435 Jenkins slaves need access to pluto to move tarballs to a
  # distribution directory when tests succeed. Needs ssh access to pluto
  # and write access to the enterprise dist dir. SSH keys are managed outside
  # of the account type

  @account::user { 'gitbackups':
    uid     => 22001,
    group   => 'backupusers',
    tag     => 'backupusers',
    comment => 'Backup acount for for git.puppetlabs.net',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDOE5KtdIIAzQZG74pu1QHZDgrCT+qv7UhDpEGZIrgcqmxEOeFWdjj7o8N4nRLm224pys1Zg2sDIzV/73YnTcyC4LiJkpCS60cC9nW2dQ4wx/nV31XnnndIqB1S5wlODLAhvYGPBu6xFotxeOXb4x5Pk9jThtk7Ol5yqab6IJn+hsp2dGph/ZQZ7xQR9IyfeOHCxF3IEShGNbISozLqWdnU9QkAlwudGcIlycxO9WNW0tmcrZDgI+B03zOsZzLrsPIH4T+QCxbimz0xjKmgl0XGbTnnR3C58+Z01o4VBYdR97N9nsXnIECuHb5xA/xXOUIVJJKs9h9G3kJ+O5YT0mfJ',
    keytype => 'ssh-rsa',
  }

  @account::user { 'git':
    comment => 'Git User',
    group   => git,
    tag     => git,
  }

  @account::user { 'hudson':
    comment => 'Hudson User',
    group   => hudson,
    tag     => hudson,
  }

  @account::user { 'patchwork':
    comment => 'Patchwork User',
    usekey  => false,
    group   => patchwork,
    tag     => patchwork,
  }

  @account::user { 'osqa':
    comment => 'OSQA User',
    usekey  => false,
    group   => osqa,
    tag     => osqa,
  }

  # (#11486) Jenkins slaves need access to rpm-builder, deb-builder, and pluto
  # to initiate builds and create preview releases for gated releases.  In
  # general, this account is for automating the process of building releases.
  # Ssh keys are managed in virtual::ssh_authorized_keys instead of here since
  # keys could vary on a per-host basis.
  @account::user { 'jenkins':
    uid     => 22002,
    comment => 'Jenkins User',
    group   => 'jenkins',
    tag     => 'jenkins',
    groups  => ["enterprise", "release"],
    usekey  => false, # Keys are managed outside of the account::user class.
  }
}
