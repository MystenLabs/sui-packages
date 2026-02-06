module 0xf1f6aad6635b667b3d659bce864dabf9cc7099f870ea078dc68fdcff7d81ef61::admin_cap {
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

    // decompiled from Move bytecode v6
}

