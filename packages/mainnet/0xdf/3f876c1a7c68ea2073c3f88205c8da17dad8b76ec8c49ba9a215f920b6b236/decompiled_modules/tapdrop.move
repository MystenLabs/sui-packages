module 0xf10457e03e683bc7a544cd148cda2ed978e863f31a2e721b936f2394b6c3074a::tapdrop {
    struct Ping has store, key {
        id: 0x2::object::UID,
    }

    public fun destroy(arg0: Ping) {
        let Ping { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun ping(arg0: &mut 0x2::tx_context::TxContext) : Ping {
        Ping{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v7
}

