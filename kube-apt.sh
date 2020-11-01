#!/bin/bash

VERSION=$1

sudo apt-mark unhold kubelet kubeadm kubectl
sudo apt-get install -y kubelet=$VERSION kubeadm=$VERSION kubectl=$VERSION docker.io
sudo apt-mark hold kubelet kubeadm kubectl
