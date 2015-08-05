Vagrant.configure("2") do |config|
  # Use vagrant.localdomain as hostname.
  hostname = "vagrant.localdomain"

  # Add vagrant.localdomain to hosts.
  config.vm.provision :shell, :inline => "echo '127.0.0.1 #{hostname}' >> /etc/hosts"

  # Install Puppet playhouse requirements.
  # rsync, ruby and rubygems
  config.vm.provision :shell, :inline => "yum -y install rsync ruby rubygems"

  config.vm.define "centos6", :autostart => false do |node|
    node.vm.box = "puppetlabs/centos-6.6-64-nocm"

    # Update hostname
    config.vm.provision :shell, :inline => [
      "sed -i 's/HOSTNAME=.*/HOSTNAME=#{hostname}/g' /etc/sysconfig/network",
      "hostname #{hostname}"
    ].join(" && ")
  end

  config.vm.define "centos7" do |node|
    node.vm.box = "puppetlabs/centos-7.0-64-nocm"

    # Update hostname
    config.vm.provision :shell, :inline => "hostnamectl set-hostname #{hostname}"

    # Install chrony to sync time.
    config.vm.provision :shell, :inline => "yum -y install chrony"
  end
end
