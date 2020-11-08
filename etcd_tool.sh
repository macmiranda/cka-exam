#!/bin/zsh
ENDPOINTS=$(kubectl -n kube-system get nodes -l node-role.kubernetes.io/master -o jsonpath='{ .items[*].status.addresses[0].address }')" "
CMD="ETCDCTL_API=3 ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key etcdctl --endpoints=${${ENDPOINTS//[[:space:]]/:2379,}:0:-1}"

case $1 in
	status)
	  kubectl -n kube-system exec etcd-$(hostname) -- sh -c "$CMD --write-out=table endpoint status"
;;
	health)
	  kubectl -n kube-system exec etcd-$(hostname) -- sh -c "$CMD --write-out=table endpoint health"
;;
	snapshot)
	  kubectl -n kube-system exec etcd-$(hostname) -- sh -c "ETCDCTL_API=3 ETCDCTL_CACERT=/etc/kubernetes/pki/etcd/ca.crt ETCDCTL_CERT=/etc/kubernetes/pki/etcd/server.crt ETCDCTL_KEY=/etc/kubernetes/pki/etcd/server.key etcdctl snapshot save /var/lib/etcd/snapshot.db"
;;
	*)
	  echo "must provide [option], can either be status, health or snapshot"
;;

esac
