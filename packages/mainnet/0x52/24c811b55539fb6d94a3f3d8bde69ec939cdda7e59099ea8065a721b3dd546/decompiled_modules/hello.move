module 0x5224c811b55539fb6d94a3f3d8bde69ec939cdda7e59099ea8065a721b3dd546::hello {
    struct Message has store, key {
        id: 0x2::object::UID,
        from: address,
        to: address,
        message: 0x1::string::String,
    }

    struct MessageEvent has copy, drop {
        from: address,
        to: address,
        message: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun say(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg0);
        let v1 = Message{
            id      : 0x2::object::new(arg2),
            from    : 0x2::tx_context::sender(arg2),
            to      : arg1,
            message : v0,
        };
        0x2::transfer::transfer<Message>(v1, arg1);
        let v2 = MessageEvent{
            from    : 0x2::tx_context::sender(arg2),
            to      : arg1,
            message : v0,
        };
        0x2::event::emit<MessageEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

