all: build tag push stop-service update-service start-service
all-clean: build-clean tag push stop-service update-service start-service

IMAGES = elasticsearch logstash kibana
IMAGE_PREFIX = elk

image-repos:
	$(foreach var,$(IMAGES),aws ecr create-repository --repository-name $(var);)

build:
	docker-compose build

build-clean:
	docker-compose build --no-cache

cluster-config:
	ecs-cli configure --cluster ${AWS_ECS_CLUSTER} \
		--compose-service-name-prefix ${AWS_ECS_CLUSTER}-elk-service- \
		--compose-profile-name-prefix ${AWS_ECS_CLUSTER}-elk-service- \
		--cfn-stack-name-prefix amazon-ecs-cli-${IMAGE_PREFIX}-

# Destructive
cluster-down: stop-service clean-service
	ecs-cli down --force

# Destructive
cluster-rebuild: cluster-down wait wait cluster-up

tag:
	$(foreach var,$(IMAGES),docker tag dockerelk_$(var) $(IMAGE_PREFIX)-$(var);)

push:
	$(foreach var,$(IMAGES),ecs-cli push $(IMAGE_PREFIX)-$(var):latest;)

local: build local-run

local-debug:
	docker-compose up

local-run:
	docker-compose up -d

local-stop:
	docker-compose down

vagrant:
	vagrant up

wait:
	sleep 60

update-service: clean-service wait create-service

clean-service: cluster-config
	docker-compose -f docker-compose.yml -f docker-compose-aws.yml config | \
	  sed "s/version: '2.1'/version: 2/" | \
	  ecs-cli compose --verbose --file /dev/stdin service down

ps-service: cluster-config
	docker-compose -f docker-compose.yml -f docker-compose-aws.yml config | \
	  sed "s/version: '2.1'/version: 2/" | \
	  ecs-cli compose --verbose --file /dev/stdin service ps

create-service: cluster-config
	docker-compose -f docker-compose.yml -f docker-compose-aws.yml config | \
	  sed "s/version: '2.1'/version: 2/" | \
	  ecs-cli compose --verbose --file /dev/stdin service create

start-service: cluster-config
	docker-compose -f docker-compose.yml -f docker-compose-aws.yml config | \
	  sed "s/version: '2.1'/version: 2/" | \
	  ecs-cli compose --verbose --file /dev/stdin service start

stop-service: cluster-config
	-docker-compose -f docker-compose.yml -f docker-compose-aws.yml config | \
	  sed "s/version: '2.1'/version: 2/" | \
	  ecs-cli compose --verbose --file /dev/stdin service stop
