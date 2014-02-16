case node.platform_family
when 'rhel'
  node.default.openssl.ca_dir = "/etc/pki/tls/certs"
when 'ubuntu'
  node.default.openssl.ca_dir = "/etc/ssl/certs"
end

node.default.openssl.private_CAs = [ ] 
