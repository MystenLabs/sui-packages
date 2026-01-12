module 0xa2973cf5d553a241751670d4bd92d7340caf5716096d60c8cd2683f8538af31::hello {
    struct Greeting has store, key {
        id: 0x2::object::UID,
        message: 0x1::string::String,
    }

    struct GreetingCreated has copy, drop {
        message: 0x1::string::String,
        recipient: address,
    }

    public fun get_message(arg0: &Greeting) : 0x1::string::String {
        arg0.message
    }

    public fun say_custom(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Greeting{
            id      : 0x2::object::new(arg2),
            message : 0x1::string::utf8(arg0),
        };
        let v1 = GreetingCreated{
            message   : v0.message,
            recipient : arg1,
        };
        0x2::event::emit<GreetingCreated>(v1);
        0x2::transfer::transfer<Greeting>(v0, arg1);
    }

    public fun say_hello(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Greeting{
            id      : 0x2::object::new(arg0),
            message : 0x1::string::utf8(b"Hello, SUI!"),
        };
        let v1 = GreetingCreated{
            message   : v0.message,
            recipient : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<GreetingCreated>(v1);
        0x2::transfer::transfer<Greeting>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

