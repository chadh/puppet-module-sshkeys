sshkeys Puppet module

## Description

This module ensures that the sshkeys script is installed and provides user defined types for defining ssh key pairs.

The sshkeys script manages host keys and user keys.  The host keys are stored in `sshkeys::install::hostkeydir` and the user keys are stored in `sshkeys::install::userkeydir`.  The script operates in two modes:

1. knownhosts file generation - Depending on how many hosts you have and how
much turnover, this is probably best run only periodically as a cron job.  It
will consoldiate all the host keys into `known_hosts` file format that is
suitable for intallation in either `/etc/ssh/ssh_known_hosts` or
`~/.ssh/known_hosts`.

2. key retrieval - The script can retrieve any of the keys it has stored.  If
the key does not exist, the script will generate an *unencrypted* key pair and
return that.  If you want an encrypted key, you have to manually install it in
the key store.

## Example

To add an entry to jon@foo's `.ssh/authorized_keys` file to allow
john@tokyo.foo.bar log in:

```puppet
node foo {
  sshkeys::authorizedkey{ 'john-tokyo':
    srcuser => 'john',
    srchost => 'tokyo.foo.bar',
    dstuser => 'jon',
  }
}
```

When compiling the catalog, the sshkeys script will grab `<userkeydir>/john.tokyo.foo.bar.rsa.pub`.
