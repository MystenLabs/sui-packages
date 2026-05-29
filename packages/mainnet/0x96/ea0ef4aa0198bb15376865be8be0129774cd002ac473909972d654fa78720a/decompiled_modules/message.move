module 0x96ea0ef4aa0198bb15376865be8be0129774cd002ac473909972d654fa78720a::message {
    struct Message has store, key {
        id: 0x2::object::UID,
        sender: address,
        recipient: address,
        created_ms: u64,
        text: 0x1::string::String,
    }

    public entry fun burn(arg0: Message) {
        let Message {
            id         : v0,
            sender     : _,
            recipient  : _,
            created_ms : _,
            text       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun send(arg0: address, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Message{
            id         : 0x2::object::new(arg3),
            sender     : 0x2::tx_context::sender(arg3),
            recipient  : arg0,
            created_ms : 0x2::clock::timestamp_ms(arg2),
            text       : arg1,
        };
        0x2::transfer::public_transfer<Message>(v0, arg0);
    }

    // decompiled from Move bytecode v7
}

