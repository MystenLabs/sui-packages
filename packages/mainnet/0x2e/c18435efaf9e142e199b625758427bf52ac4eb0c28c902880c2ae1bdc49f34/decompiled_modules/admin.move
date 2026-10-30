module 0x2ec18435efaf9e142e199b625758427bf52ac4eb0c28c902880c2ae1bdc49f34::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0x4b178f7855b2e84ae9c1585093009bb6c212cd3b5ccf9c76672dda04be087e0);
    }

    public fun treasury() : address {
        @0x4b178f7855b2e84ae9c1585093009bb6c212cd3b5ccf9c76672dda04be087e0
    }

    // decompiled from Move bytecode v7
}

