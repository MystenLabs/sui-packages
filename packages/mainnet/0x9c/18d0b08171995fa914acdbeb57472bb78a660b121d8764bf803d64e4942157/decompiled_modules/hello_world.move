module 0x9c18d0b08171995fa914acdbeb57472bb78a660b121d8764bf803d64e4942157::hello_world {
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

