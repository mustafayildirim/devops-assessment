#!/bin/bash

kubectl create namespace jenkins
kubectl get namespaces
kubectl apply -f /vagrant/jenkins/Deployment.yaml --namespace jenkins
kubectl apply -f /vagrant/jenkins/Service.yaml --namespace jenkins