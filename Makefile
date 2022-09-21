create-topic:
	@read -p "Enter Topic Name: " topic; \
	read -p "Enter Topic Partitions number: " partitions; \
	read -p "Enter Topic Replication factor: " replication; \
	docker exec operations bash -c \
				"./bin/kafka-topics.sh --bootstrap-server broker1:9092 --create --partitions $$partitions --replication-factor $$replication --topic $$topic"
delete-topic:
	@read -p "Enter Topic Name: " topic; \
	docker exec -it operations bash -c "./bin/kafka-topics.sh --bootstrap-server broker1:9092 --topic $$topic --delete"