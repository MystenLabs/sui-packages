module 0x5aa6851c634273ebfb1765dc96f8604d0c317f6c882fc7a34b989d5c052cd56::greeting {
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

