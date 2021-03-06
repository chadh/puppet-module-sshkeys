  define sshkeys::privatekey (
    $user,
    $host,
    $type = 'rsa'
  ) {
    include sshkeys

    $typeopt = $type ? {
      'rsa' => '--rsa',
      'dsa' => '--dsa',
      default => 'unknown',
    }
    if $typeopt == 'unknown' {
      fail("sshkeys::privatekey defined with unknown type ($type)")
    }
  
    file { $name:
      content => generate($sshkeys::scriptname,
        '--private',
        '--user', $user,
        '--cmthost', $host,
        $typeopt
      ),
      mode => '0400',
      owner => $user,
      group => 'root',
    }
  }
