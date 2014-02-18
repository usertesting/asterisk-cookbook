defaults_path = case node['platform_family']
when 'debian'
  '/etc/default/asterisk'
when 'rhel'
  '/etc/default/asterisk'
end

template defaults_path do
  source 'init/default-asterisk.erb'
  mode 0644
  notifies :restart, resources('service[asterisk]')
end
