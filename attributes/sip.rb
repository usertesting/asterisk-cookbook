default['asterisk']['sip_conf_context']              = 'default'
default['asterisk']['sip_conf_allowguest']           = 'yes'
default['asterisk']['sip_confallowoverlap']          = 'no'
default['asterisk']['sip_conf_allowtransfer']        = 'no'
default['asterisk']['sip_conf_realm']                = 'mydomain.com'
default['asterisk']['sip_conf_domain']               = 'mydomain.com'
default['asterisk']['sip_conf_bindport']             = 5060
default['asterisk']['sip_conf_bindaddr']             = '0.0.0.0'
default['asterisk']['sip_conf_tcpenable']            = 'yes'
default['asterisk']['sip_conf_srvlookup']            = 'yes'
default['asterisk']['sip_conf_pedantic']             = 'yes'
default['asterisk']['sip_conf_tos_sip']              = 'cs3'
default['asterisk']['sip_conf_tos_audio']            = 'ef'
default['asterisk']['sip_conf_tos_video']            = 'af41'
default['asterisk']['sip_conf_maxexpiry']            = '3600'
default['asterisk']['sip_conf_minexpiry']            = 60
default['asterisk']['sip_conf_defaultexpiry']        = 120
default['asterisk']['sip_conf_t1min']                = 100
default['asterisk']['sip_conf_notifymimetype']       = 'text/plain'
default['asterisk']['sip_conf_checkmwi']             = 10
default['asterisk']['sip_conf_buggymwi']             = 'no'
default['asterisk']['sip_conf_vmexten']              = 'voicemail'
default['asterisk']['sip_conf_disallow']             = 'all'
default['asterisk']['sip_conf_allow']                = %w(ulaw gsm ilbc speex)
default['asterisk']['sip_conf_mohinterpret']         = 'default'
default['asterisk']['sip_conf_mohsuggest']           = 'default'
default['asterisk']['sip_conf_language']             = 'en'
default['asterisk']['sip_conf_relaxdtmf']            = 'yes'
default['asterisk']['sip_conf_trustrpid']            = 'no'
default['asterisk']['sip_conf_sendrpid']             = 'yes'
default['asterisk']['sip_conf_progressinband']       = 'never'
default['asterisk']['sip_conf_useragent']            = 'Asterisk with Adhearsion'
default['asterisk']['sip_conf_promiscredir']         = 'no'
default['asterisk']['sip_conf_usereqphone']          = 'no'
default['asterisk']['sip_conf_dtmfmode']             = 'rfc2833'
default['asterisk']['sip_conf_compactheaders']       = 'yes'
default['asterisk']['sip_conf_videosupport']         = 'yes'
default['asterisk']['sip_conf_maxcallbitrate']       = 384
default['asterisk']['sip_conf_callevents']           = 'no'
default['asterisk']['sip_conf_alwaysauthreject']     = 'yes'
default['asterisk']['sip_conf_g726nonstandard']      = 'yes'
default['asterisk']['sip_conf_matchexterniplocally'] = 'yes'
default['asterisk']['sip_conf_regcontext']           = 'sipregistrations'
default['asterisk']['sip_conf_rtptimeout']           = 60
default['asterisk']['sip_conf_rtpholdtimeout']       = 300
default['asterisk']['sip_conf_rtpkeepalive']         = 60
default['asterisk']['sip_conf_sipdebug']             = 'yes'
default['asterisk']['sip_conf_recordhistory']        = 'yes'
default['asterisk']['sip_conf_dumphistory']          = 'yes'
default['asterisk']['sip_conf_allowsubscribe']       = 'no'
default['asterisk']['sip_conf_subscribecontext']     = 'default'
default['asterisk']['sip_conf_notifyringing']        = 'yes'
default['asterisk']['sip_conf_notifyhold']           = 'yes'
default['asterisk']['sip_conf_limitonpeers']         = 'yes'
default['asterisk']['sip_conf_t38pt_udptl']          = 'yes'

# Setup our SIP Providers
default['asterisk']['sip_providers'] = Mash.new
default['asterisk']['sip_providers']['flowroute'] = Mash.new(:type => 'friend', :host => 'sip.flowroute.com', :dtmf_mode => 'rfc2833', :context => 'flowroute', :canreinvite => 'no', :allowed_codecs => ['ulaw', 'g729'], :insecure => 'port,invite', :qualify => 'yes')

# Sensible defaults for public ip
default['asterisk']['public_ip'] = node['ec2'] ? node['ec2']['public_ipv4'] : node['ipaddress']
