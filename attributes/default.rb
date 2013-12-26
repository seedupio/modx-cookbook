#
# Author:: Ivan Klimchuk (ivan@klimchuk.com)
# Cookbook Name:: modx
# Attributes:: modx
#
# December 2013
#
# License text - MIT
#

default[:modx][:version] = "2.2.10-pl"
default[:modx][:dir] = "/var/www/modx"

default[:modx][:db][:type] = "mysql"
default[:modx][:db][:host] = "localhost"
default[:modx][:db][:name] = "modx"
default[:modx][:db][:user] = "modx"

default[:modx][:site][:email] = "mail@modx.modx"
default[:modx][:site][:username] = "modxuser"
default[:modx][:site][:password] = "modxpass"

::Chef::Node.send(:include, Opscode::OpenSSL::Password)

set_unless[:modx][:db][:pass] = secure_password

#default[:modx][:github_url] = "https://github.com/modxcms/revolution"
#default[:modx][:github_version] = "master"

default[:modx][:extras] = ["Ace", "getResources", "getPage"]

default[:modx][:apache][:port] = "80"