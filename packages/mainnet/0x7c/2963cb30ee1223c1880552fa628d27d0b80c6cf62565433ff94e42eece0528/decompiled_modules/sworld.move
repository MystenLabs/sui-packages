module 0x7c2963cb30ee1223c1880552fa628d27d0b80c6cf62565433ff94e42eece0528::sworld {
    struct HelloEvent has copy, drop, store {
        message: vector<u8>,
        sender: address,
    }

    public fun say_hello(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HelloEvent{
            message : arg0,
            sender  : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<HelloEvent>(v0);
    }

    public fun say_hello_default(arg0: &mut 0x2::tx_context::TxContext) {
        say_hello(b"Hello, Sui!", arg0);
    }

    // decompiled from Move bytecode v6
}

