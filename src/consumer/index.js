const { Kafka } = require('kafkajs')

const kafka = new Kafka({
  clientId: 'david-producer-project',
  brokers: ['174.138.4.24:9092', '174.138.4.24:9093'],
})

const consumer = kafka.consumer({ groupId: 'a' })

const eachMessage = async ({ topic, partition, message, heartbeat, pause }) => {
    const {value} = message 
    console.log(value);
} 

const start = async () => {
    await consumer.connect()
    await consumer.subscribe({ topics: ['tx2'] });
    await consumer.run({eachMessage});
}
 
start().then(() => console.log('start success'));