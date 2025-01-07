module 0x54af127ef8b2231528d274143c4229ecd4d3e75247c9305768d1220a7a5eef60::demo {
    struct Demo has store, key {
        id: 0x2::object::UID,
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) : Demo {
        Demo{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

