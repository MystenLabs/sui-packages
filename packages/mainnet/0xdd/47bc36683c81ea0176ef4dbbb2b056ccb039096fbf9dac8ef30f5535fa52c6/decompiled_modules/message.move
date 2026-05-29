module 0xdd47bc36683c81ea0176ef4dbbb2b056ccb039096fbf9dac8ef30f5535fa52c6::message {
    struct Message has store, key {
        id: 0x2::object::UID,
        party_a: address,
        party_b: address,
        sender: address,
        recipient: address,
        created_ms: u64,
        updated_ms: u64,
        seq: u64,
        text: 0x1::string::String,
    }

    public fun burn(arg0: Message) {
        let Message {
            id         : v0,
            party_a    : _,
            party_b    : _,
            sender     : _,
            recipient  : _,
            created_ms : _,
            updated_ms : _,
            seq        : _,
            text       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun reply(arg0: Message, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.recipient, 1);
        let v1 = if (v0 == arg0.party_a) {
            arg0.party_b
        } else {
            assert!(v0 == arg0.party_b, 2);
            arg0.party_a
        };
        arg0.sender = v0;
        arg0.recipient = v1;
        arg0.updated_ms = 0x2::clock::timestamp_ms(arg2);
        arg0.seq = arg0.seq + 1;
        arg0.text = arg1;
        0x2::transfer::public_transfer<Message>(arg0, v1);
    }

    public fun resend(arg0: Message, arg1: address, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        arg0.party_a = v0;
        arg0.party_b = arg1;
        arg0.sender = v0;
        arg0.recipient = arg1;
        arg0.updated_ms = 0x2::clock::timestamp_ms(arg3);
        arg0.seq = arg0.seq + 1;
        arg0.text = arg2;
        0x2::transfer::public_transfer<Message>(arg0, arg1);
    }

    public fun send(arg0: address, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = Message{
            id         : 0x2::object::new(arg3),
            party_a    : v0,
            party_b    : arg0,
            sender     : v0,
            recipient  : arg0,
            created_ms : v1,
            updated_ms : v1,
            seq        : 0,
            text       : arg1,
        };
        0x2::transfer::public_transfer<Message>(v2, arg0);
    }

    // decompiled from Move bytecode v7
}

