# Environment scenarios

Various scenarios or separate k8s resource ready to deploy

## Use cases

- static environment serving as a bait network for malicious actors
- easy to deploy k8s environment for CI/CD

## Prerequisites

- (OPTIONAL) for dokcer-compose deployable application use [kompose](https://kompose.io/) tool
    - it translates docker-compose files to k8s resources
    - ```bash
      # generates k8s resource (of any kind) files in the current directory
      kompose --file private_scenario/compose.yml convert

      # generates k8s resoruces directly in k8s (ONLY deployments and services are deployed)
      kompose --file private_scenario/compose.yml up
      ```
- **NOTE: creating these scenarios directly with `kompose up` requires `kubectl`!**


## Scenarios

### WIP private scenario

path: [private_scenario](./private_scenario)

- pods/deployment
    - web (e.g. gitea, custom webpage)
    - internal only db (e.g. mysql, postgresql)
    - mail server
    - FTP server

- services
    - publishing web, mail and FTP

## About

**Author:** Tomáš Belluš

**License:** MIT
