module 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GovernanceCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GovernanceCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<GovernanceCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

