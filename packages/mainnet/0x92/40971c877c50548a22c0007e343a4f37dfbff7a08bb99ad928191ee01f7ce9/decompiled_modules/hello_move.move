module 0x9240971c877c50548a22c0007e343a4f37dfbff7a08bb99ad928191ee01f7ce9::hello_move {
    struct HelloMove has key {
        id: 0x2::object::UID,
        say: 0x1::string::String,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HelloMove{
            id  : 0x2::object::new(arg0),
            say : 0x1::string::utf8(b"move"),
        };
        0x2::transfer::transfer<HelloMove>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

