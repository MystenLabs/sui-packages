module 0x753713f93a067f9329d768f6602fdec6a8636a23d2c6049d6d1c6d5e852e9e91::hello {
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

