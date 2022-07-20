IMG=kubeberth/berth-archiver:v1alpha1

.PHONY: docker-build
docker-build: ## Build docker image with the manager.
	docker build --no-cache -t $(IMG) .

.PHONY: docker-push
docker-push: ## Push docker image with the manager.
	docker push $(IMG)

.PHONY: docker-buildx
docker-buildx:
	docker buildx build --no-cache --platform linux/amd64,linux/arm64 -t $(IMG) --push .
