const { Kafka } = require('kafkajs')
var i = 0;
    partitions = 6;
    partition = 0;

const kafka = new Kafka({
  clientId: 'david-producer-project',
  brokers: ['broker1:9092', 'broker2:9092', 'broker3:9092'],
})


const topic = kafka.topic()


const producer = kafka.producer()

const sender = async () => {

    i++;
    await producer.connect()
    const response = await producer.send({
    topic: 'seisPtresR',
    messages: [
        { key: 'key1', value: 'hello world' + i, partition: 3 },
        { key: 'key2', value: 'hey hey!' + i, partition }
    ],
    })
    await producer.disconnect()   
    console.log(`${i} sended: ${JSON.stringify(response)}`);
    console.log(partition);
    partition = ++partition >= partitions ? 0 : partition;
}

const intereval = setInterval(sender, 400);
