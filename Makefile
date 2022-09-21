create-topic:
	@read -p "Enter Topic Name: " topic; \
	read -p "Enter Topic Partitions number: " partitions; \
	read -p "Enter Topic Replication factor: " replication; \
	docker exec operations bash -c \
				"./bin/kafka-topics.sh --bootstrap-server broker1:9092 --create --partitions $$partitions --replication-factor $$replication --topic $$topic"

describe-topic:
	@read -p "Enter Topic Name: " topic; \
	docker exec -it operations bash -c "./bin/kafka-topics.sh --bootstrap-server broker2:9092 --topic $$topic --describe"

describe-groups:
	docker exec -it operations bash -c "./bin/kafka-consumer-groups.sh --bootstrap-server broker2:9092 --describe --all-groups"

delete-topic:
	@read -p "Enter Topic Name: " topic; \
	docker exec -it operations bash -c "./bin/kafka-topics.sh --bootstrap-server broker1:9092 --topic $$topic --delete"

producer:
	@read -p "Enter Topic Name: " topic; \
	docker exec -it producer bash -c "./bin/kafka-console-producer.sh --bootstrap-server broker2:9092 --topic $$topic "

consumer:
	@read -p "Enter Topic Name: " topic; \
	read -p "Enter Group Name: " group; \
	docker exec -it producer bash -c "./bin/kafka-console-consumer.sh --bootstrap-server broker2:9092 --topic $$topic --group $$group --from-beginning"



operations:
	docker exec -it operations bash
