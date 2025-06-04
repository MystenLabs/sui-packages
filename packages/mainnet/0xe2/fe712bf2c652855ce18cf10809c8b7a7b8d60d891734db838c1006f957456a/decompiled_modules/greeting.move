module 0xe2fe712bf2c652855ce18cf10809c8b7a7b8d60d891734db838c1006f957456a::greeting {
    struct Greeting has store, key {
        id: 0x2::object::UID,
        message: 0x1::string::String,
    }

    public fun create_greeting(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Greeting{
            id      : 0x2::object::new(arg1),
            message : 0x1::string::utf8(arg0),
        };
        0x2::transfer::share_object<Greeting>(v0);
    }

    public fun get_message(arg0: &Greeting) : 0x1::string::String {
        arg0.message
    }

    // decompiled from Move bytecode v6
}

