module 0xcfa1e2bfe2fa384824c5f71a8677d475ba2559e48171b9b0ce72888930e6ed28::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun init_admin(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

