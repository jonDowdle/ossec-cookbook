#
# Cookbook Name:: ossec
# Recipe:: server
#
# Copyright 2010, Opscode, Inc.
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

agent_manager = "#{node['ossec']['user']['dir']}/bin/ossec-batch-manager.pl"

node.run_state[:ssh_hosts] = []

search_string = "ossec:[* TO *]"
search_string << " AND chef_environment:#{node['ossec']['server_env']}" if node['ossec']['server_env']
search_string << " NOT role:#{node['ossec']['server_role']}"

search(:node, search_string) do |n|
  add_to_ossec = !n['ipaddress'].nil?
  Chef::Log.warn "#{n} NOT ADDED BECAUSE IPADDRESS IS NOT SET" if add_to_ossec
  node.run_state[:ssh_hosts] << n['ipaddress'] if add_to_ossec
 
  agent_id = n['fqdn'][0..31] rescue ""
  agent_id = n['ipaddress'].gsub('.','_') if agent_id.empty? rescue n['name']

  execute "#{agent_manager} -a --ip #{n['ipaddress']} -n #{agent_id}" do
    only_if { add_to_ossec }
    not_if "grep '#{agent_id} #{n['ipaddress']}' #{node['ossec']['user']['dir']}/etc/client.keys"
    notifies :restart, "service[ossec]", :delayed
  end  
end
