default: docker
include .env

# Note:
#	Latest version of kubectl may be found at: https://github.com/kubernetes/kubernetes/releases
# 	Latest version of helm may be found at: https://github.com/kubernetes/helm/releases
# 	Latest version of yq may be found at: https://github.com/mikefarah/yq/releases
VARS:=$(shell sed -ne 's/ *\#.*$$//; /./ s/=.*$$// p' .env )
$(foreach v,$(VARS),$(eval $(shell echo export $(v)="$($(v))")))
DOCKER_IMAGE ?= petebachant/helm-kubectl-awscli
DOCKER_TAG ?= `git rev-parse --short HEAD`

docker:
	@docker build \
	  --build-arg KUBE_VERSION=$(KUBE_VERSION) \
	  --build-arg HELM_VERSION=$(HELM_VERSION) \
	  --build-arg YQ_VERSION=$(YQ_VERSION) \
	  -t $(DOCKER_IMAGE):$(DOCKER_TAG) -t $(DOCKER_IMAGE):latest .

push-docker:
	# Push to DockerHub
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
	docker push $(DOCKER_IMAGE):latest
