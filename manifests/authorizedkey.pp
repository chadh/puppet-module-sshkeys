# This define will export a resource that says "authorize the key for
# $srcuser@$srchost to login as $dstuser on *this host* ($::hostname)"
# $srcuser is only used as a comment on the key, and as an identifier to locate
# the key in the keystore (ie, the filename of the key)
define sshkeys::authorizedkey (
  $srcuser,
  $srchost,
  $dstuser,
  $authorizedkey_file,
  $keytype = 'rsa',
) {
   #FIXME This is a total hack.  sshkeys.pl returns a key in the form "options ssh-rsa KEY foo@bar"
   # so we split them out here.  Really, we should refactor the sshkeys.pl script (or store them elsewhere)
   $key = generate("${sshkeys::install::bindir}/sshkeys.pl", '--user', $srcuser, "--${keytype}", '--authkeys', $srchost, '--cmthost', $srchost)
   $rawkeyarr = split($key,' ')
   $keyopts = $rawkeyarr[0]
   $rawkey = $rawkeyarr[2]
   ssh_authorized_key { $name:
     ensure => present,
     key => $rawkey,
     options => $keyopts,
     user => $dstuser,
     type => $keytype,
   }
}