# This define will export a resource that says "authorize the key for
# $srcuser@$srchost to login as $dstuser on *this host* ($::hostname)"
# $srcuser is only used as a comment on the key, and as an identifier to locate
# the key in the keystore (ie, the filename of the key)
define sshkeys::authorizedkey (
  $srcuser,
  $srchost,
  $dstuser,
  $ensure = 'present',
  $authorizedkey_file = 'UNSET',
  $keytype = 'rsa',
) {
  include sshkeys
  # FIXME This is a total hack.  sshkeys.pl returns a key in the form "options ssh-rsa KEY foo@bar"
  # so we split them out here.  Really, we should refactor the sshkeys.pl script (or store them elsewhere)
  $key = generate($sshkeys::scriptname, '--user', $srcuser, "--${keytype}", '--authkeys', $srchost, '--cmthost', $srchost)
  $rawkeyarr = split($key, ' ')
  $keyopts = $rawkeyarr[0]
  $rawkey = $rawkeyarr[2]

  if $authorizedkey_file == 'UNSET' {
    ssh_authorized_key { $name:
      ensure  => $ensure,
      key     => $rawkey,
      options => $keyopts,
      user    => $dstuser,
      type    => $keytype,
    }
  } else {
    ssh_authorized_key { $name:
      ensure  => $ensure,
      key     => $rawkey,
      options => $keyopts,
      user    => $dstuser,
      target  => $authorizedkey_file,
      type    => $keytype,
    }
  }
}
