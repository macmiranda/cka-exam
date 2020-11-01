#!/bin/bash

VERSION=$1

sudo sed -i "/$(hostname)/s/^.*$/$(hostname -I|awk '{print $1}') $(hostname)/" /etc/hosts
sudo kubeadm init --pod-network-cidr=10.168.0.0/16 --control-plane-endpoint=$(hostname) --upload-certs --kubernetes-version="stable-$VERSION"

mkdir -p $HOME/.kube
sudo cp -a /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#kubectl delete -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
#kubectl delete -f https://docs.projectcalico.org/manifests/custom-resources.yaml
kubectl create -f https://docs.projectcalico.org/manifests/calico.yaml 
