#
# Cookbook Name:: openssl
# Recipe:: private_ca
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# INSTALL PRIVATE CAs into the OpenSSL Framework

# node.openssl.private_CAs is expected to be a list of CA certs
# that are already placed within node.openssl.ca_dir
# this recipe will get the openssl hash for each and create a symbolic link
# to the cert such that openssl will add it to the chain

# manual instructions which this recipe replicates
# http://gagravarr.org/writing/openssl-certs/others.shtml

ruby_block "add CAs to openssl" do 
  block do
    node.openssl.private_CAs.each do |ca|
      ca_file = "#{node.openssl.ca_dir}/#{ca}"

      Chef::Log.info("DEBUG: ca_file is: #{ca_file}")
      
      unless system("ls -l | grep \\\\-\\> #{ca_file} 2>&1 > /dev/null")

        unless system("[ \`grep -c 'BEGIN.* CERTIFICATE' #{ca_file}\` = '1' ]")
          Chef::Application.fatal!("There can only be one certificate in #{ca_file}")
        end

        hash = `openssl x509 -noout -hash -in #{ca_file}`
        `cd #{node.openssl.ca_dir} &&  ln -s #{ca_file} #{hash}.0`
      end
    end
  end
end

