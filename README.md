# helm-kubernetes Docker hub image with the AWS CLI

[![ci](https://github.com/petebachant/helm-kubectl-awscli/actions/workflows/image-build-push.yaml/badge.svg)](https://github.com/dtzar/helm-kubectl/actions/workflows/image-build-push.yaml)
[![Docker Stars](https://img.shields.io/docker/stars/petebachant/helm-kubectl-awscli.svg?style=flat)](https://hub.docker.com/r/petebachant/helm-kubectl-awscli/)
[![Docker Pulls](https://img.shields.io/docker/pulls/petebachant/helm-kubectl-awscli.svg?style=flat)](https://hub.docker.com/r/petebachant/helm-kubectl-awscli/)

This is a fork of
https://github.com/dtzar/helm-kubectl
that adds the AWS CLI.

## Overview

This lightweight alpine docker image provides kubectl and helm binaries for working with a Kubernetes cluster.
A local configured kubectl is a prerequisite to use helm per [helm documentation](https://github.com/kubernetes/helm/blob/master/docs/quickstart.md).
This image is useful for general helm administration such as deploying helm charts and managing releases.
It is also perfect for any automated deployment pipeline needing to use helm which supports docker images such as [Concourse CI](https://concourse.ci), [Jenkins on Kubernetes](https://kubeapps.com/charts/stable/jenkins), [Travis CI](https://docs.travis-ci.com/user/docker/),
and [Circle CI](https://circleci.com/integrations/docker/).
Having bash installed allows for better support for troubleshooting by being able to exec / terminal in and run desired shell scripts.
Git installed allows installation of [helm plugins](https://github.com/kubernetes/helm/blob/master/docs/plugins.md).

If it is desired to only use kubectl and have kubectl as the entry command (versus this image as bash entry command), I recommend checking out this image instead:
[lachlanevenson/kubectl](https://hub.docker.com/r/lachlanevenson/k8s-kubectl/)

## Run

Example to just run helm on entry:
`docker run --rm petebachant/helm-kubectl-awscli helm`
By default kubectl will try to use /root/.kube/config file for connection to the kubernetes cluster, but does not exist by default in the image.

Example for use with personal administration or troubleshooting with volume mount for kubeconfig files:
`docker run -it -v ~/.kube:/root/.kube petebachant/helm-kubectl-awscli`
The -v maps your host docker machine Kubernetes configuration directory (~/.kube) to the container's Kubernetes configuration directory (root/.kube).

## Build

For doing a manual local build of the image:
`make docker_build`
