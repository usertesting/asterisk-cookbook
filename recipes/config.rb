external_ip = node[:ec2] ? node[:ec2][:public_ipv4] : node[:ipaddress]
users = search(:asterisk_users) || []
auth = search(:auth, "id:google") || []
dialplan_contexts = search(:asterisk_contexts) || []

node['asterisk']['configure'].each do |config, managed|
  next unless managed == true
  template "/etc/asterisk/#{component}.conf" do
    source "#{component}.conf.erb"
    mode 0644
    variables :external_ip => external_ip, :users => users, :auth => auth[0], :dialplan_contexts => dialplan_contexts
    notifies :reload, resources(:service => 'asterisk')
  end
end

