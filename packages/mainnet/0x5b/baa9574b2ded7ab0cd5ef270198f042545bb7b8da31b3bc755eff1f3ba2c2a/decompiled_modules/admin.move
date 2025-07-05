module 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

