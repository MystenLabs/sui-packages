module 0xbe22d5391b2abdfdc5808bd42d3a8d155c6789469e6185c99f2a641deb7bce0f::vault_admin_cap {
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

