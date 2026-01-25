module 0xcccd2bfd5743fc1231aa9b58bd790ab37b5723e8bc1a237c3889bdf09b3a6340::greeting {
    struct Greeting has key {
        id: 0x2::object::UID,
        text: 0x1::string::String,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Greeting{
            id   : 0x2::object::new(arg0),
            text : 0x1::string::utf8(b"Good Morning World! I love Sui :)"),
        };
        0x2::transfer::share_object<Greeting>(v0);
    }

    public fun update_text(arg0: &mut Greeting, arg1: 0x1::string::String) {
        arg0.text = arg1;
    }

    // decompiled from Move bytecode v6
}

