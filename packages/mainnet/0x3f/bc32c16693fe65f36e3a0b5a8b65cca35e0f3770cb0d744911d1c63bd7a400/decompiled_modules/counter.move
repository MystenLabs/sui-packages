module 0x3fbc32c16693fe65f36e3a0b5a8b65cca35e0f3770cb0d744911d1c63bd7a400::counter {
    struct Hello has store, key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Hello{
            id   : 0x2::object::new(arg0),
            text : 0x1::string::utf8(b"hello world, hello Sui!"),
        };
        0x2::transfer::share_object<Hello>(v0);
    }

    // decompiled from Move bytecode v6
}

