module 0x939124909b564d987483d7326b8f708e00ee4ae6ed8a43c3bd9a9d980a5bcf85::hello {
    struct Hello has key {
        id: 0x2::object::UID,
        say: 0x1::ascii::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hello{
            id  : 0x2::object::new(arg0),
            say : 0x1::ascii::string(b"move"),
        };
        0x2::transfer::transfer<Hello>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

