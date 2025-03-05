module 0x71fbe411e1e80bf262e5c09fbba0d6e4fc4c843045ca8fd0754c4fa1135e51d8::mover {
    struct Mover has store, key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Mover {
        Mover{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

