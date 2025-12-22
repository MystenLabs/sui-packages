module 0x6d5aeb1e7f85c93c65eca49a974f0d496f00261d6e8855de9044c54c9e7123c4::admin_cap {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct InitEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = InitEvent{admin_cap_id: 0x2::object::id<AdminCap>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

