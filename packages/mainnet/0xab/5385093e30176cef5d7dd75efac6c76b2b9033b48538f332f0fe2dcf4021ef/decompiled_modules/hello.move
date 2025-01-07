module 0xab5385093e30176cef5d7dd75efac6c76b2b9033b48538f332f0fe2dcf4021ef::hello {
    struct Hello has key {
        id: 0x2::object::UID,
        say: 0x1::ascii::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hello{
            id  : 0x2::object::new(arg0),
            say : 0x1::ascii::string(b"first limu sui subjection"),
        };
        0x2::transfer::transfer<Hello>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

