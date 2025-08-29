module 0x6102c662c190253751ba4a17fdac0e4dbaa5e42cd6f00f12d0876bcc29e15220::treasury_cap {
    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TreasuryCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

