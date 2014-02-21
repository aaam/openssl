#
# Cookbook Name:: openssl-test
# Recipe:: place_private_CAs
#
# Copyright (C) 2014 Sam Cooper
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

CAs = %w{ cacert_root.pem cacert_class_3.pem }

openssl_root = case node['platform_family']
when 'rhel', 'fedora'
  "/etc/pki/tls/certs"
when 'debian'
  "/etc/ssl/certs"
end

CAs.each { |ca| cookbook_file "#{openssl_root}/#{ca}" }


