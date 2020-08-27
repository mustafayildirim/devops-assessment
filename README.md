# devops-assessment

# Initial command to up
vagrant up --provision-with ansible

# To Configure Kubectl config and check system
vagrant provision k8s-master --provision-with kube-config,check

# Take a snapshot
vagrant snapshot save initial-kubernetes-install

# To Install Nexus
vagrant provision k8s-master --provision-with nexus

# To Install Jenkins
vagrant provision k8s-master --provision-with jenkins