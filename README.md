# devops-assessment

# Initial command to up
vagrant up --provision-with ansible

# Take a snapshot
vagrant snapshot save initial-kubernetes-install

# To Install Nexus
vagrant provision k8s-master --with-provision nexus

# To Install Jenkins
vagrant provision k8s-master --with-provision jenkins