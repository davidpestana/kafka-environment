bootstrap-server = broker3:9092,broker2:9092,broker1:9092


start:
	docker compose up -d
	docker compose logs -f 

du:
	du --max-depth=2 -h data/

cleanup:
	docker compose down --remove-orphans
	docker rm -f $(docker ps -aq) 

create-topic:
	@read -p "Enter Topic Name: " topic; \
	read -p "Enter Topic Partitions number: " partitions; \
	read -p "Enter Topic Replication factor: " replication; \
	docker compose -f tools.yaml run --rm tools bash -c \
			"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --create --partitions $$partitions --replication-factor $$replication --topic $$topic"

describe-topic:
	@read -p "Enter Topic Name: " topic; \
	docker compose -f tools.yaml run --rm tools bash -c \
			"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --topic $$topic --describe"


list-topic:
	docker compose -f tools.yaml run --rm tools bash -c \
			"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --list"

list-groups:
	docker compose -f tools.yaml run --rm tools bash -c \
			"./bin/kafka-consumer-groups.sh --bootstrap-server $(bootstrap-server) --list"

describe-groups:
	docker compose -f tools.yaml run --rm tools bash -c \
			"./bin/kafka-consumer-groups.sh --bootstrap-server $(bootstrap-server) --describe --all-groups"

describe-group:
	@read -p "Enter Group Name: " group; \
	docker compose -f tools.yaml run --rm tools bash -c \
			"./bin/kafka-consumer-groups.sh --bootstrap-server $(bootstrap-server) --describe --group $$group"

delete-topic:
	@read -p "Enter Topic Name: " topic; \
	docker compose -f tools.yaml run --rm tools bash -c \
			"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --topic $$topic --delete"

launch_autoproducer:
	docker compose -f tools.yaml run --rm producer

producer:
	@read -p "Enter Topic Name: " topic; \
	docker compose -f tools.yaml run --rm tools bash -c \
			"./bin/kafka-console-producer.sh --bootstrap-server $(bootstrap-server) --topic $$topic "

consumer:
	@read -p "Enter Topic Name: " topic; \
	read -p "Enter Group Name: " group; \
	docker compose -f tools.yaml run --rm tools bash -c \
			"./bin/kafka-console-consumer.sh --bootstrap-server $(bootstrap-server) --topic $$topic --group $$group"

consumer-p:
	@read -p "Enter Topic Name: " topic; \
	read -p "Enter Partition Id: " partition; \
	docker compose -f tools.yaml run --rm tools bash -c \
			"./bin/kafka-console-consumer.sh --bootstrap-server $(bootstrap-server) --topic $$topic --partition $$partition"

consumer-fb:
	@read -p "Enter Topic Name: " topic; \
	read -p "Enter Group Name: " group; \
	docker compose -f tools.yaml run --rm tools bash -c \
			"./bin/kafka-console-consumer.sh --bootstrap-server $(bootstrap-server) --topic $$topic --group $$group --from-beginning"