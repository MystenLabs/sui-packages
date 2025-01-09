module 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::events {
    struct MessageSentEvent has copy, drop {
        message: 0x1::ascii::String,
    }

    struct MessageReceivedEvent has copy, drop {
        message: 0x1::ascii::String,
    }

    public(friend) fun message_received_event(arg0: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message) {
        let v0 = MessageReceivedEvent{message: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::to_hex(&arg0)};
        0x2::event::emit<MessageReceivedEvent>(v0);
    }

    public(friend) fun message_sent_event(arg0: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message) {
        let v0 = MessageSentEvent{message: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::to_hex(&arg0)};
        0x2::event::emit<MessageSentEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

