Vagrant.configure("2") do |config|
  #config.vm.box = "centos-64-x64-vbox4210"
  #config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"
  config.vm.box = "centos-64-x64-vbox4210-nocm"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box"

  # Resolve puppet to 127.0.0.1
  config.vm.provision :shell, :inline => "echo '127.0.0.1 puppet' >> /etc/hosts"

  # Disable DNS lookup for SSH connection (Sometimes it causes slow `vagrant ssh`)
  config.vm.provision :shell, :inline => "echo 'UseDNS = no' >> /etc/ssh/sshd_config && " <<
                                         "service sshd restart"

  # Set "vagrant" as certname on this host.
  #config.vm.provision :shell, :inline => "sed -i -e 's/\\[main\\]/[main]\\n    certname = vagrant\\n/' " <<
  #                                       "/etc/puppet/puppet.conf"
  config.vm.provision :shell, :inline => "mkdir -p /etc/puppet && " <<
                                         "echo -e '[main]\\n    certname = vagrant' >> /etc/puppet/puppet.conf"

  # Install ruby and bundler
  config.vm.provision :shell, :inline => "yum -y install ruby rubygems && " <<
                                         "gem install bundler"
end
