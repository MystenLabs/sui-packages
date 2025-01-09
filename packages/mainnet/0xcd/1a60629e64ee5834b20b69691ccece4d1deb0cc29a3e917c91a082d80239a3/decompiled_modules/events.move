module 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::events {
    struct MessageSentEvent has copy, drop {
        message: 0x1::ascii::String,
        sequence: u64,
    }

    struct MessageReceivedEvent has copy, drop {
        message: 0x1::ascii::String,
        sequence: u64,
    }

    public(friend) fun message_received_event(arg0: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message, arg1: u64) {
        let v0 = MessageReceivedEvent{
            message  : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::to_hex(&arg0),
            sequence : arg1,
        };
        0x2::event::emit<MessageReceivedEvent>(v0);
    }

    public(friend) fun message_sent_event(arg0: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message, arg1: u64) {
        let v0 = MessageSentEvent{
            message  : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::to_hex(&arg0),
            sequence : arg1,
        };
        0x2::event::emit<MessageSentEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

