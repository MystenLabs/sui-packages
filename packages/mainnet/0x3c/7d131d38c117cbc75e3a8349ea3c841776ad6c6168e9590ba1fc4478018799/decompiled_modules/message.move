module 0x3c7d131d38c117cbc75e3a8349ea3c841776ad6c6168e9590ba1fc4478018799::message {
    struct Message has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        content: vector<u8>,
        timestamp: u64,
    }

    struct MessageCreated has copy, drop {
        id: u64,
        sender: address,
        recipient: address,
    }

    fun emit_message_created(arg0: u64, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MessageCreated{
            id        : arg0,
            sender    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MessageCreated>(v0);
    }

    public entry fun get_message(arg0: &Message) : (address, address, vector<u8>, u64) {
        (arg0.sender, arg0.recipient, arg0.content, arg0.timestamp)
    }

    public entry fun send_message(arg0: address, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Message{
            id        : 0x2::object::new(arg3),
            sender    : arg0,
            recipient : arg1,
            content   : arg2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        emit_message_created(v0.timestamp, arg0, arg1, arg3);
        0x2::transfer::public_transfer<Message>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

