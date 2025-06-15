module 0x9870209da74094b8a92c515dac71a006f4f636a5c6db5fbb8a86a0b97b0f2a2c::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

