bootstrap-server = 174.138.4.24:9092

create-topic:
	@read -p "Enter Topic Name: " topic; \
	read -p "Enter Topic Partitions number: " partitions; \
	read -p "Enter Topic Replication factor: " replication; \
	docker exec operations bash -c \
				"./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --create --partitions $$partitions --replication-factor $$replication --topic $$topic"

describe-topic:
	@read -p "Enter Topic Name: " topic; \
	docker exec -it operations bash -c "./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --topic $$topic --describe"

describe-groups:
	docker exec -it operations bash -c "./bin/kafka-consumer-groups.sh --bootstrap-server $(bootstrap-server) --describe --all-groups"

delete-topic:
	@read -p "Enter Topic Name: " topic; \
	docker exec -it operations bash -c "./bin/kafka-topics.sh --bootstrap-server $(bootstrap-server) --topic $$topic --delete"

producer:
	@read -p "Enter Topic Name: " topic; \
	docker exec -it producer bash -c "./bin/kafka-console-producer.sh --bootstrap-server $(bootstrap-server) --topic $$topic "

consumer:
	@read -p "Enter Topic Name: " topic; \
	read -p "Enter Group Name: " group; \
	docker exec -it producer bash -c "./bin/kafka-console-consumer.sh --bootstrap-server $(bootstrap-server) --topic $$topic --group $$group --from-beginning"

operations:
	docker exec -it operations bash