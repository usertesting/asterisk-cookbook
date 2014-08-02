case node['platform_family']
when 'debian'
  apt_repository 'asterisk' do
    uri node['asterisk']['package']['repo']['url']
    distribution node['asterisk']['package']['repo']['distro']
    components node['asterisk']['package']['repo']['branches']
    keyserver node['asterisk']['package']['repo']['keyserver']
    key node['asterisk']['package']['repo']['key']
    only_if { node['asterisk']['package']['repo']['enable'] }
  end
when 'rhel'
  node['asterisk']['package']['repo']['urls'].each do |name, url|
    yum_repository name do
      description "Asterisk yum repo"
      baseurl url
      gpgcheck false
      action :create
      only_if { node['asterisk']['package']['repo']['enable'] }
    end
  end
end

node['asterisk']['package']['names'].each do |pkg|
  package pkg
end
