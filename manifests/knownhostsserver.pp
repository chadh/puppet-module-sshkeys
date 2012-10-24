class openssh::sshkeys::knownhostsserver {
  cron { 'genknownhosts':
    command => "${sshkeys::store::scriptname} --genknownhosts",
    user    => 'root',
    minute  => [ 0,10,20,30,40,50 ],
  }
}