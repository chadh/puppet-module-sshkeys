class sshkeys::install(
  $user,
  $hostkeydir,
  $userkeydir,
  $keygen,
  $keygenopts,
  $knownhosts_servedir,
) {
  include sshkeys
  
  file { $sshkeys::scriptname:
    content => template('sshkeys/sshkeys.pl.erb'),
    mode    => '0500',
    owner   => $user,
    group   => 'root',
  }
  
  file { [ $hostkeydir, $userkeydir ]:
    ensure => directory,
    mode   => '0700',
    owner  => $user,
    group  => 'root',
  }
  
  if $knownhosts_servedir != 'UNSET' {
    file { $knownhosts_servedir:
      ensure => directory,
      mode => '755',
      owner => $user,
      group => 'root',
    }
  }
  
  file { "$hostkeydir/.known_hosts.lck":
    content => '',
    mode => '0600',
    owner => $user,
    group => 'root',
  }

  cron { 'genknownhosts':
    command => "$sshkeys::scriptname --genknownhosts",
    user    => 'root',
    minute  => [ 0,10,20,30,40,50 ],
  }  
}