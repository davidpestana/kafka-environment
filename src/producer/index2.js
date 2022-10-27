var kafka = require('kafka-node'),
    Producer = kafka.Producer,
    client = new kafka.KafkaClient({kafkaHost: '174.138.4.24:9092, 174.138.4.24:9093'}),
    producer = new Producer(client);
var i = 0;




    const sender = async () => {    
        i ++;
        const partition = Math.random()*10 % 2 > 1 ? 0 : 1;
        console.log(partition);
        const payload = {
            topic: 'tx',
            messages: ['enviando solo a un topic' + i], // multi messages should be a array, single message can be just a string or a KeyedMessage instance
            key: 'theKey', // string or buffer, only needed when using keyed partitioner
            partition, // default 0
            attributes: 2, // default: 0
            timestamp: Date.now() // <-- defaults to Date.now() (only available with kafka v0.10+)
        }

        const payloads = [payload];

        producer.send(payloads, (response) => {
            console.log(response);
        });

    }


    producer.on('ready', function () {
        const intereval = setInterval(sender, 10);
    });
    