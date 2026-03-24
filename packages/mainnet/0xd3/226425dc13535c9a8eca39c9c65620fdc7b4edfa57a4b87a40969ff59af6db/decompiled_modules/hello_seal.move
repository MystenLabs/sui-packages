module 0xd3226425dc13535c9a8eca39c9c65620fdc7b4edfa57a4b87a40969ff59af6db::hello_seal {
    struct SealedMessage has store, key {
        id: 0x2::object::UID,
        encrypted_message: vector<u8>,
        sender: address,
        recipient: address,
    }

    struct MessageCreated has copy, drop {
        message_id: 0x2::object::ID,
        sender: address,
        recipient: address,
    }

    public entry fun create_message(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = SealedMessage{
            id                : 0x2::object::new(arg2),
            encrypted_message : arg0,
            sender            : v0,
            recipient         : arg1,
        };
        let v2 = MessageCreated{
            message_id : 0x2::object::id<SealedMessage>(&v1),
            sender     : v0,
            recipient  : arg1,
        };
        0x2::event::emit<MessageCreated>(v2);
        0x2::transfer::share_object<SealedMessage>(v1);
    }

    public fun get_encrypted_message(arg0: &SealedMessage) : &vector<u8> {
        &arg0.encrypted_message
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &SealedMessage, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (arg1.recipient != @0x0) {
            assert!(v0 == arg1.sender || v0 == arg1.recipient, 0);
        };
    }

    // decompiled from Move bytecode v6
}

