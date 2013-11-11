install_samples = node['asterisk']['source']['install_samples']
source_version = node['asterisk']['source']['version']
source_checksum = node['asterisk']['source']['checksum']
source_tarball = "asterisk-#{source_version}.tar.gz"
source_url = node['asterisk']['source']['url'] ||
    "http://downloads.asterisk.org/pub/telephony/asterisk/releases/#{source_tarball}"
source_path = "#{Chef::Config['file_cache_path'] || '/tmp'}/#{source_tarball}"
node.default['asterisk']['prefix']['bin'] = "/opt/asterisk-#{source_version}"

case node['platform']
when "ubuntu", "debian"
  node['asterisk']['source']['packages'].each do |pkg|
    package pkg do
      options "--force-yes"
    end
  end
end

config_opts = %W(
    --prefix=#{node['asterisk']['prefix']['bin']}
    --sysconfdir=#{node['asterisk']['prefix']['conf']}
    --localstatedir=#{node['asterisk']['prefix']['state']}
)
cache_conditions = {
    :source_version => source_version,
    :source_checksum => source_checksum,
    :config_opts => config_opts,
    :install_samples => install_samples
}

resource_cache 'build asterisk' do
  conditions cache_conditions
  resources do
    remote_file source_tarball do
      source source_url
      path source_path
      checksum source_checksum
      backup false
      notifies :create, 'ruby_block[validate asterisk tarball]', :immediately
    end

    # The checksum on remote_file is used only to determine if a file needs downloading
    # Here we verify the checksum for security/integrity purposes
    ruby_block 'validate asterisk tarball' do
      action :nothing
      block do
        require 'digest'
        expected = source_checksum
        actual = Digest::SHA256.file(source_path).hexdigest
        if expected and actual != expected
          raise "Checksum mismatch on #{source_path}.  Expected sha256 of #{expected} but found #{actual} instead"
        end
      end
    end

    bash 'install_asterisk' do
      user 'root'
      cwd File.dirname(source_path)
      code <<-EOH
        tar zxf #{source_path}
        cd asterisk-#{source_version}
        ./configure #{config_opts.join(' ')}
        make
        make install
        make config
        #{'make samples' if install_samples}
      EOH
      notifies :reload, resources('service[asterisk]')
    end
  end
end
