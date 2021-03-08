# Private scenario

## prerequisites

- when using NFS storage:
    - install the `nfs-kernel-server` package on the all nodes
    - refer to a [playbook](https://github.com/tomas321/masters_thesis/blob/develop/ansible/playbooks/nfs.yml) or the [official docs](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner)

- create a LoadBalancer "provider" MetalLB
    - refer to a [playbook](https://github.com/tomas321/masters_thesis/blob/develop/ansible/playbooks/metallb.yml) or the [official docs](https://metallb.universe.tf/)

- create a storage class to automatically create PersistentVolume (PV) when creating PersistentVolumeClaim (PVC).
    - this kind of storage class is created when running the mentioned (above) playbook for NFS
    - ```yaml
      apiVersion: storage.k8s.io/v1
      kind: StorageClass
      metadata:
        name: nfs-storage
        annotations:
          storageclass.kubernetes.io/is-default-class: "true"
      provisioner: kubernetes.io/no-provisioner
      reclaimPolicy: Retain
      volumeBindingMode: WaitForFirstConsumer
      ```

## gitea

**Prerequisites**

- all of common prerequisites
- MetalLB configured with desired configmaps for external IP ranges i.e. for gitea point of access IPs
    - in this repository it is the `metallb.universe.tf/address-pool` annotation in any of the loadbalancer resource objects

**Deployment**

To deploy a self-hosted git system using Gitea, create the resources in [gitea_k8s_resources](gitea_k8s_resources/) as so:

```bash
cd gitea_k8s_resources/
kubectl create -f gitea-pvc.yaml \
               -f gitea-http-loadbalancer.yaml \
               -f gitea-ssh-loadbalancer.yaml \
               -f gitea-deployment.yaml
```

Running `kubectl get pv,pvc`, verify whether the PV and PVC s successfully bound

**Setup**

Connect to the gitea homepage via `http://<gitea external IP>` e.g. `http://10.0.0.100` given that:

```bash
$ kubectl get service gitea-ssh-loadbalancer gitea-http-loadbalancer
NAME                      TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
gitea-ssh-loadbalancer    LoadBalancer   10.233.23.144   10.0.0.101    2222:31616/TCP   4m
gitea-http-loadbalancer   LoadBalancer   10.233.57.183   10.0.0.100    80:32627/TCP     4m

```

There is the intial configuration page for Gitea. Only change the _SSH Server Domain_, _SSH Server Port_ and _Gitea Base URL_ to `10.0.0.101`, `2222` and `http://10.0.0.100/` respenctively

In case of any problems refer to this [link](https://packetriot.com/tutorials/posts/setting-up-gitea/)
