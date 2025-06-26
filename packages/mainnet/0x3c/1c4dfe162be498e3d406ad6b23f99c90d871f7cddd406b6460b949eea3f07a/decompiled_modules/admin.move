module 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

