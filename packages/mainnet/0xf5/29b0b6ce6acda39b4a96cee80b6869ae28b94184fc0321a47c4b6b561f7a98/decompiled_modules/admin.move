module 0xf529b0b6ce6acda39b4a96cee80b6869ae28b94184fc0321a47c4b6b561f7a98::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

