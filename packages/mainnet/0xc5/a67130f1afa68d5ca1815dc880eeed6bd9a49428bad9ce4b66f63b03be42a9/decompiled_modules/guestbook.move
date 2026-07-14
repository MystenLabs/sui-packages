module 0xc5a67130f1afa68d5ca1815dc880eeed6bd9a49428bad9ce4b66f63b03be42a9::guestbook {
    struct Message has key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::string::String,
        text: 0x1::string::String,
        created_at: u64,
        updated_at: u64,
    }

    public fun create_message(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Message{
            id         : 0x2::object::new(arg3),
            owner      : v0,
            name       : arg0,
            text       : arg1,
            created_at : arg2,
            updated_at : arg2,
        };
        0x2::transfer::transfer<Message>(v1, v0);
    }

    public fun update_message(arg0: &mut Message, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        arg0.text = arg1;
        arg0.updated_at = arg2;
    }

    // decompiled from Move bytecode v7
}

