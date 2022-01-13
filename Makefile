IMAGE_NAME = ovgucsworkshops/docker-userland
TAG = v0.1.0

build:
	docker buildx build -t ${IMAGE_NAME}:latest -t ${IMAGE_NAME}:${TAG} . --push
