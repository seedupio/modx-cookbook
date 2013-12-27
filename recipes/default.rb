#
# Author:: Ivan Klimchuk (ivan@klimchuk.com)
# Cookbook Name:: modx
# Attributes:: modx
#
# December 2013
#
# License text - MIT
#

include_recipe %w{apache2 apache2::mod_php5 apache2::mod_rewrite apache2::mod_expires}
package 'php5' do action :install end
package 'php-mysql' do action :install end
package 'php-gd' do action :install end

include_recipe "mysql::server"

execute "modx-privileges" do
    command "/usr/bin/mysql -h #{node[:modx][:setup][:database][:server]} -u root -p#{node[:mysql][:server_root_password]} < /etc/mysql/modx-grants.sql"
    action :nothing
end

template "/etc/mysql/modx-grants.sql" do
    path "/etc/mysql/modx-grants.sql"
    source "grants.sql.erb"
    owner "root"
    group "root"
    mode "0600"
    variables(
        :user => mode[:modx][:setup][:database][:username],
        :pass => mode[:modx][:setup][:database][:password],
        :name => mode[:modx][:setup][:database][:database],
        :host => mode[:modx][:setup][:database][:server]
    )
    notifies :run, "execute[modx-privileges]", :immediately
end

execute "create #{node[:modx][:setup][:database][:database]} database" do
    command "/usr/bin/mysqladmin -h #{node[:modx][:setup][:database][:server]} -u root -p#{node[:mysql][:server_root_password]} create #{node[:modx][:setup][:database][:database]}"
    not_if "mysql -h #{node[:modx][:setup][:database][:server]} -u root -p#{node[:mysql][:server_root_password]} --silent --skip-column-names --execute=\"show databases like '#{node[:modx][:setup][:database][:database]}'\" | grep #{node[:modx][:setup][:database][:database]}"
end

# --------------------

#execute "download-and-install-modx" do
#    cwd File.dirname(node[:modx][:dir])
#    # command "" // wget ?
#end

# --------------------

web_app "modx" do
    template "modx.conf.erb"
    docroot node[:modx][:dir]
    server_name server_fqdn
    server_aliases node[:fqdn]
end

execute "disable-default-site" do
    command "sudo a2dissite default"
    notifies :reload, "service[apache2]", :delayed
    only_if do File.exists? "#{node[:apache][:dir]}/site-enabled/default" end
end
