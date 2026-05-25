module 0x3ecf1a84d491d1027e6ff23b38e0e0ac6a318ca3013d57727fecb0bb2bec2560::admin_cap {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCapCreatedEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
    }

    public fun id(arg0: &AdminCap) : 0x2::object::ID {
        0x2::object::id<AdminCap>(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = AdminCapCreatedEvent{admin_cap_id: 0x2::object::id<AdminCap>(&v0)};
        0x2::event::emit<AdminCapCreatedEvent>(v1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

