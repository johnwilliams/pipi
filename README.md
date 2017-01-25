## Install Kubernetes
You'll need to become root then add the apt-key for google. Next you'll add the kubernetes apt repo and finally update the apt repos and then install kubeadm. This should be completed on the master and the nodes.
```sudo su -
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
apt-get update && apt-get install -y kubeadm
```

## Setup Master
Kubenetes is now installed so you can initiaze the master node by running the following command:
```kubeadm init --pod-network-cidr 10.244.0.0/16
```

## Join Nodes
Now that your master is up and running you will want to join nodes to the cluster. The command will be shown at the end of the output from the init command you ran above. Run this command on the nodes.
```kubeadm join --token=ee2abc.a0a4aaaf5b471a1d 192.168.2.2
```

## Check Node Status
```$ kubectl get nodes
NAME            STATUS         AGE
pi-k8s-master   Ready,master   6m
pi-k8s-node1    Ready          14s
pi-k8s-node2    Ready          8s
pi-k8s-node3    Ready          6s
```

## Setup Network Driver (flannel)
As of today flannel is the only network driver that works on Rpi
```curl -sSL https://rawgit.com/coreos/flannel/master/Documentation/kube-flannel.yml | sed "s/amd64/arm/g" | kubectl create -f -
```

## List app tier pods:
```$ kubectl get pods -l tier=app
NAME                        READY     STATUS    RESTARTS   AGE
pipi-app-3795598666-32tzt   1/1       Running   0          32m
pipi-app-3795598666-jd73n   1/1       Running   1          32m
pipi-app-3795598666-qt8dl   1/1       Running   0          32m
```

## Run DB migration on an app pod.
```kubectl exec pipi-app-3795598666-32tzt bin/rails db:migrate```