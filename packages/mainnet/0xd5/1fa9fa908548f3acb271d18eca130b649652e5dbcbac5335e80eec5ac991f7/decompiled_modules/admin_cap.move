module 0xd51fa9fa908548f3acb271d18eca130b649652e5dbcbac5335e80eec5ac991f7::admin_cap {
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

