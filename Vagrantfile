Vagrant.configure("2") do |config|
  config.vm.box = "centos-64-x64-vbox4210"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"

  # Disable DNS lookup for SSH connection
  # Resolve puppet to 127.0.0.1
  # Set "vagrant" as certname on this host.
  config.vm.provision :shell, :inline => <<-'END_OF_SCRIPT'
    echo 'UseDNS = no' >> /etc/ssh/sshd_config
    echo '127.0.0.1 puppet' >> /etc/hosts
    sed -i -e 's/\[main\]/[main]\n    certname = vagrant\n/' /etc/puppet/puppet.conf
    service sshd restart
  END_OF_SCRIPT
end
