module 0x661d8cd9c52cfc945ce3396a468f85e88104c86a17204fcd6131beba339134e2::hello_move {
    struct HelloMove has store, key {
        id: 0x2::object::UID,
        say: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HelloMove{
            id  : 0x2::object::new(arg0),
            say : 0x1::string::utf8(b"move"),
        };
        0x2::transfer::public_transfer<HelloMove>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

