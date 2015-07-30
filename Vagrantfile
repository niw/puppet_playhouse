Vagrant.configure("2") do |config|
  config.vm.box = "puppetlabs/centos-7.0-64-nocm"

  # Use vagrant.localdomain as hostname.
  config.vm.provision :shell, :inline => "hostnamectl set-hostname vagrant.localdomain"

  # Add vagrant.localdomain to hosts.
  config.vm.provision :shell, :inline => "echo '127.0.0.1 vagrant.localdomain' >> /etc/hosts"

  # Install chrony to sync time.
  config.vm.provision :shell, :inline => "yum -y install chrony"

  # Install Puppet playhouse requirements.
  # rsync, ruby and rubygems
  config.vm.provision :shell, :inline => "yum -y install rsync ruby rubygems"
end
