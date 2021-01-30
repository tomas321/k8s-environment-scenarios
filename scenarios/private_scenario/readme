
### prerequisites

- when using NFS storage:
    - install the `nfs-kernel-server` package on the all nodes

- create a LoadBalancer "provider" MetalLB
    - refer to a [playbook](https://github.com/tomas321/masters_thesis/blob/develop/ansible/playbooks/metallb.yml) or the [official docs](https://metallb.universe.tf/)

- (optional) setup nginx ingress controller via kubespray
    - nginx ingress controller acts as a reverse proxy and load balancer
    - create ConfigMap for tcp connection mapping exposed pod ports
    - create ConfigMap for udp connection mapping exposed pod ports
    - PodSecurityPolicy to secure the security aspects of pod specifications
    - and other role related objects

- configure the ingress resource
