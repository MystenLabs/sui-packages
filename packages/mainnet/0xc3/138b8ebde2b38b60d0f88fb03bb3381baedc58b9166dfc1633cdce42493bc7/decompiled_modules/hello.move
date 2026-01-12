module 0xc3138b8ebde2b38b60d0f88fb03bb3381baedc58b9166dfc1633cdce42493bc7::hello {
    struct Greeting has store, key {
        id: 0x2::object::UID,
        message: 0x1::string::String,
    }

    public fun get_message(arg0: &Greeting) : 0x1::string::String {
        arg0.message
    }

    public fun say_custom(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : Greeting {
        Greeting{
            id      : 0x2::object::new(arg1),
            message : 0x1::string::utf8(arg0),
        }
    }

    public fun say_hello(arg0: &mut 0x2::tx_context::TxContext) : Greeting {
        Greeting{
            id      : 0x2::object::new(arg0),
            message : 0x1::string::utf8(b"Hello, SUI!"),
        }
    }

    // decompiled from Move bytecode v6
}

