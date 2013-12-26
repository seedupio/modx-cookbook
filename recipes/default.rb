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
include_recipe %w{php php::module_mysql php::module_gd} # module_* is deprecated, must to be replaced
# package 'php-mysql' do action :install end

# centos - still without centos, only ubuntu
case node['platform_family']
when 'rhel', 'fedora'
    package 'php-dom' do
        action :install
    end
end

# mysql server install
include_recipe "mysql::server"

# setup mysql grants
execute "mysql-install-modx-privileges" do
    command "/usr/bin/mysql -h #{node[:modx][:db][:host]} -u root -p#{node[:mysql][:server_root_password]} < /etc/mysql/modx-grants.sql" # ??
    action :nothing
end

template "/etc/mysql/modx-grants.sql" do
    path "/etc/mysql/modx-grants.sql"
    source "grants.sql.erb"
    owner "root"
    group "root"
    mode "0600"
    variables(
        :user => mode[:modx][:db][:user],
        :pass => mode[:modx][:db][:pass],
        :name => mode[:modx][:db][:name],
        :host => mode[:modx][:db][:host]
    ) # we can simplify this
    notifies :run, "execute[mysql-install-modx-privileges]", :immediately
end

execute "create #{node[:modx][:db][:name]} database" do
    command "/usr/bin/mysqladmin -h #{node[:modx][:db][:host]} -u root -p#{node[:mysql][:server_root_password]} create #{node[:modx][:db][:name]}"
    not_if "mysql -h #{node[:modx][:db][:host]} -u root -p#{node[:mysql][:server_root_password]} --silent --skip-column-names --execute=\"show databases like '#{node[:modx][:db][:database]}'\" | grep #{node[:modx][:db][:name]}"
end

# install modx
execute "download-and-install-modx" do
    cwd File.dirname(node[:modx][:dir])
    # command "" // wget ?
end

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
