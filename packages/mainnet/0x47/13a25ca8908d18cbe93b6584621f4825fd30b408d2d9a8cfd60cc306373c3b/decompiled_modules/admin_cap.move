module 0x4713a25ca8908d18cbe93b6584621f4825fd30b408d2d9a8cfd60cc306373c3b::admin_cap {
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

