  define sshkeys::privatekey (
    $user,
    $host,
    $type = 'rsa'
  ) {
    $typeopt = $type ? {
      'rsa' => '--rsa',
      'dsa' => '--dsa',
      default => 'unknown',
    }
    if $typeopt == 'unknown' {
      fail("sshkeys::privatekey defined with unknown type ($type)")
    }
  
    file { $name:
      content => generate($sshkeys::install::scriptname,
        '--private',
        '--user', $user,
        '--cmthost', $host,
        $typeopt
      ),
      mode => '0400',
      owner => $user,
      group => 'root',
      require => File[$sshkeys::install::scriptname],
    }
  }