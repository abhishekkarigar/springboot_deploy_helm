APP_NAME        ?= karigartest
DOCKER_REGISTRY ?= $(shell minikube ip):5002
BUILD_VERSION	?= 0.0.0-snapshot
CURWD           ?= .
.PHONY: environment-start
environment-start: ## start the services in docker-compose file
	docker-compose up -d --build

.PHONY: environment-stop
environment-stop: ## stop the services in docker-compose file
	docker-compose down -v

.PHONY: docker-build
docker-build: ## build service docker image
	docker build --rm -t ${APP_NAME} ${CURWD}
	docker tag ${APP_NAME} ${DOCKER_REGISTRY}/${APP_NAME}:latest
	docker tag ${APP_NAME} ${DOCKER_REGISTRY}/${APP_NAME}:${BUILD_VERSION}

.PHONY: docker-push
docker-push: ## publish docker image
	docker push ${DOCKER_REGISTRY}/${APP_NAME}:latest
	docker push ${DOCKER_REGISTRY}/${APP_NAME}:${BUILD_VERSION}

.PHONY: maven-build
maven-build: ## create the jar file
	mvn -gs ./settings.xml clean install
	
