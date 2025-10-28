module 0xa9ef7b5be6ac6974e5a839de446e2a56cfa8424e25009eb8a29ae7721e015bbe::greeting {
    struct Greeting has key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Greeting{
            id   : 0x2::object::new(arg0),
            text : 0x1::string::utf8(b"Hello world!"),
        };
        0x2::transfer::share_object<Greeting>(v0);
    }

    public fun update_text(arg0: &mut Greeting, arg1: 0x1::string::String) {
        arg0.text = arg1;
    }

    // decompiled from Move bytecode v6
}

