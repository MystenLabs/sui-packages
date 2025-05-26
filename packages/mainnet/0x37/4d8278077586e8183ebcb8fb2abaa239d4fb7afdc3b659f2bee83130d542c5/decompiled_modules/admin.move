module 0x6343bfb55a15b5ccc847223a7d96f51b68d39a66f6d9025be393421142dab037::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_admin(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

