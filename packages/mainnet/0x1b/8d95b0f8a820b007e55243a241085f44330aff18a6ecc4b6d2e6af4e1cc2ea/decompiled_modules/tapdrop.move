module 0x1b8d95b0f8a820b007e55243a241085f44330aff18a6ecc4b6d2e6af4e1cc2ea::tapdrop {
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

