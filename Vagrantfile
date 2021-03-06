IMAGE_NAME = "bento/ubuntu-16.04"
N = 2

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false
    config.vm.usable_port_range = 2200..65535

    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 2
    end
      
    config.vm.define "k8s-master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network "private_network", ip: "192.168.50.10"
        master.vm.hostname = "k8s-master"
        master.vm.provision "ansible" do |ansible|
            ansible.playbook = "kubernetes-setup/master-playbook.yml"
            ansible.extra_vars = {
                node_ip: "192.168.50.10",
            }
        end

        master.vm.provision "kube-config", type:"shell", inline: <<-SHELL
            mkdir -p $HOME/.kube
            sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
            sudo chown $(id -u):$(id -g) $HOME/.kube/config
        SHELL

        master.vm.provision "check", type:"shell", inline: <<-SHELL
            kubectl version -o json
            docker ps
            kubectl get namespace
        SHELL

        master.vm.provision "jenkins", type:"shell", path: "./jenkins/jenkins-installer.sh"
        master.vm.provision "check-jenkins", type:"shell", inline: <<-SHELL
            kubectl get pods --namespace jenkins
            # curl http://192.168.50.10:32000
            # kubectl logs jenkins-deployment-45345423412-k9003 --namespace jenkins
        SHELL

        master.vm.provision "nexus", type:"shell", path: "./nexus/nexus-installer.sh"
            
    end

    (1..N).each do |i|
        config.vm.define "node-#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "192.168.50.#{i + 10}"
            node.vm.hostname = "node-#{i}"
            node.vm.provision "ansible" do |ansible|
                ansible.playbook = "kubernetes-setup/node-playbook.yml"
                ansible.extra_vars = {
                    node_ip: "192.168.50.#{i + 10}",
                }
            end
        end
    end
end