#
# Author:: Ivan Klimchuk (ivan@klimchuk.com)
# Cookbook Name:: modx
# Attributes:: modx
#
# December 2013
#
# License text - MIT
#

default[:modx][:version] = "2.2.10-pl" # important if not use github
default[:modx][:dir] = "/var/www/modx"

#::Chef::Node.send(:include, Opscode::OpenSSL::Password)
#set_unless[:modx][:db][:pass] = secure_password

#default[:modx][:github_url] = "https://github.com/modxcms/revolution"
#default[:modx][:github_version] = "master"

default[:modx][:extras] = ["Ace", "getResources", "getPage"]
default[:modx][:apache][:port] = "80"

#----------

default[:modx][:setup][:database][:type] = "mysql"
default[:modx][:setup][:database][:server] = "localhost"
default[:modx][:setup][:database][:databse] = "modx_modx"
default[:modx][:setup][:database][:username] = "db_username"
default[:modx][:setup][:database][:password] = "db_password"
default[:modx][:setup][:database][:connection_charset] = "utf8"
default[:modx][:setup][:database][:charset] = "utf8"
default[:modx][:setup][:database][:collation] = "utf8_general_ci"
default[:modx][:setup][:database][:table_prefix] = "modx_"

default[:modx][:setup][:installation][:inplace] = "1"
default[:modx][:setup][:installation][:unpacked] = "0"
default[:modx][:setup][:installation][:language] = "en-US" # ?
default[:modx][:setup][:installation][:cmsadmin] = "username"
default[:modx][:setup][:installation][:cmspassword] = "password"
default[:modx][:setup][:installation][:cmsadminemail] = "email@address.com"
default[:modx][:setup][:installation][:remove_setup_directory] = "1"

default[:modx][:setup][:path][:context_mgr_path] = ""
default[:modx][:setup][:path][:context_mgr_url] = "" 
default[:modx][:setup][:path][:context_connectors_path] = ""
default[:modx][:setup][:path][:context_connectors_url] = ""
default[:modx][:setup][:path][:context_web_path] = ""
default[:modx][:setup][:path][:context_web_url] = ""
default[:modx][:setup][:path][:assets_path] = ""
default[:modx][:setup][:path][:assets_url] = ""
default[:modx][:setup][:path][:core_path] = ""
default[:modx][:setup][:path][:processors_path] = ""

default[:modx][:setup][:other][:https_port] = "443"
default[:modx][:setup][:other][:http_host] = "localhost"
default[:modx][:setup][:other][:cache_disabled] = "0"










