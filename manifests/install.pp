class sshkeys::install(
  $bindir,
  $user,
  $hostkeydir,
  $userkeydir,
  $keygen,
  $keygenopts,
  $knownhosts_servedir,
) {
  $scriptname = "${bindir}/sshkeys.pl"
  
  file { $scriptname:
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
  
}