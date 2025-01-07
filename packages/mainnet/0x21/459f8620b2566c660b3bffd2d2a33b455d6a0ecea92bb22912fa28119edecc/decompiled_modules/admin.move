module 0x21459f8620b2566c660b3bffd2d2a33b455d6a0ecea92bb22912fa28119edecc::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

