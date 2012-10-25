define sshkeys::hostkey(
  $keyhost,
  $private,
  $type,
  $owner = 'root',
  $group = 'root',
  $privmode = '0400',
  $pubmode = '0444'
) {
  $typeopt = $type ? {
    'rsa' => '--rsa',
    default => '--dsa',
  }
  if $private {
    $key = generate($sshkeys::install::scriptname, '--private', $typeopt, '--host', $keyhost)
    $mode = $privmode
  } else {
    $key = generate($sshkeys::install::scriptname, $typeopt, '--host', $keyhost)
    $mode = $pubmode
  }
  file { $name:
    content => $key,
    mode => $mode,
    owner => $owner,
    group => $group,
  }
}