default['asterisk']['package']['names']             = %w(asterisk asterisk-dev)
default['asterisk']['package']['repo']['enable']    = false
case platform_family
when 'debian'
  default['asterisk']['package']['repo']['url']       = 'http://packages.asterisk.org/deb'
  default['asterisk']['package']['repo']['distro']    = node['lsb']['codename']
  default['asterisk']['package']['repo']['branches']  = %w(main)
  default['asterisk']['package']['repo']['keyserver'] = 'pgp.mit.edu'
  default['asterisk']['package']['repo']['key']       = '175E41DF'
when 'rhel'
  default['asterisk']['package']['repo']['urls'] = {
    'asterisk-11' => 'http://packages.asterisk.org/centos/$releasever/asterisk-11/$basearch/',
    'asterisk-current' => 'http://packages.asterisk.org/centos/$releasever/current/$basearch/',
  }
end
