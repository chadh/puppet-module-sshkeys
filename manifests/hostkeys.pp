class sshkeys::hostkeys (
  $host,
  $owner,
  $group,
  $privmode,
  $pubmode,
) {
  include sshkeys

  openssh::server::hostkey { "${name}-rsa-private":
    key => generate($sshkeys::scriptname, '--private', '--rsa', '--host', $host),
    mode => $privmode,
    owner => $owner,
    group => $group,
  }
  openssh::server::hostkey { "${host}-rsa-public":
    key => generate($sshkeys::scriptname, '--rsa', '--host', $host),
    mode => $pubmode,
    owner => $owner,
    group => $group,
  }
  openssh::server::hostkey { "${name}-dsa-private":
    key => generate($sshkeys::scriptname, '--private', '--dsa', '--host', $host),
    mode => $privmode,
    owner => $owner,
    group => $group,
  }
  openssh::server::hostkey { "${host}-dsa-public":
    key => generate($sshkeys::scriptname, '--dsa', '--host', $host),
    mode => $pubmode,
    owner => $owner,
    group => $group,
  }
}
