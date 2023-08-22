Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-22.04"
    config.vm.hostname = "clab-workshop"
    # config.vm.network "private_network", ip: "<add-your-static-ip-here-if-required>"
    config.vm.network "private_network", type: "dhcp"

    config.vm.provider "virtualbox" do |v|
      v.name = "clab-workshop"
      v.memory = 8192
      v.cpus = 4
    end

    config.vm.synced_folder ".gitignored/", "/home/vagrant/gitignored_files"
    # run provisioning script
    config.vm.provision "shell", path: "provision_vm.sh"

  end