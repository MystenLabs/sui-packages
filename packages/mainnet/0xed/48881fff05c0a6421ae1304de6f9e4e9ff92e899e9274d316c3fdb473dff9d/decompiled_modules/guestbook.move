module 0xed48881fff05c0a6421ae1304de6f9e4e9ff92e899e9274d316c3fdb473dff9d::guestbook {
    struct Message has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        text: 0x1::string::String,
        timestamp: u64,
    }

    public fun create_message(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Message{
            id        : 0x2::object::new(arg3),
            name      : arg0,
            text      : arg1,
            timestamp : arg2,
        };
        0x2::transfer::transfer<Message>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

