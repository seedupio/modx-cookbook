maintainer          "Ivan Klimchuk"
maintainer_email    "ivan@klimchuk.com" 
license             "MIT"
name                "modx"
description         "Chef cookbook for install MODX Revolution to Vagrant environment"
long_description    IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version             "0.0.1"
recipe              "modx", "Installs and configures MODX Revolution"

%w{ postfix php apache2 mysql openssl firewall cron }.each do |cb|
    depends cb
end

%w{ debian ubuntu }.each do |os|
    supports os
end
