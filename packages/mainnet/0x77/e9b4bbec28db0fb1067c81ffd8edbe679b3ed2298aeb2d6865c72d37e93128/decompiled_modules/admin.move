module 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

