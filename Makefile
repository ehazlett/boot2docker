IMAGE_NAME?=boot2docker-docker-cs
UCP_VERSION?=1.0.1

all: build-image build-iso

ucp: build-ucp-image build-ucp-iso

cache-ucp-images:
	@for image in $$(docker run --rm docker/ucp:${UCP_VERSION} images --list) ; do \
	    export name=$$(echo $${image} | md5sum | awk '{ print $$1;   }').tar ; \
	    echo $${name} ; \
	    docker save $${image} > data/$${name} ; done

build-image:
	@docker build -t ${IMAGE_NAME} -f Dockerfile.cs .

build-ucp-image:
	@docker build -t ${IMAGE_NAME}-ucp -f Dockerfile.ucp .

build-iso: build-image
	@docker run --rm ${IMAGE_NAME} > ${IMAGE_NAME}.iso

build-ucp-iso: build-ucp-image
	@docker run --rm ${IMAGE_NAME}-ucp > ${IMAGE_NAME}-ucp.iso
