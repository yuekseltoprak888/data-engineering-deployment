# Load environment variables from .env file
include .env
export $(shell sed 's/=.*//' .env)

build_docker_image:
	docker build -t $(DOCKER_IMAGE_NAME) -f dockerfile-task-3-2 .

run_docker_image:
	docker run -p $(PORT):$(PORT) -e PORT=$(PORT) $(DOCKER_IMAGE_NAME)

push_docker_image:
	docker push $(DOCKER_IMAGE_NAME)

deploy_docker_image:
	gcloud run deploy --image $(DOCKER_IMAGE_NAME) --platform managed --region europe-west1 --allow-unauthenticated --port $(PORT)
