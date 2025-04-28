module 0x21bb57db4cb27b3ee1b168cd7b22f9e22e28b92e0e00d0d0da5e8a4db55a0da::hello {
    struct SayHello has copy, drop {
        author: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun say_hello(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SayHello{author: 0x2::tx_context::sender(arg0)};
        0x2::event::emit<SayHello>(v0);
    }

    // decompiled from Move bytecode v6
}

