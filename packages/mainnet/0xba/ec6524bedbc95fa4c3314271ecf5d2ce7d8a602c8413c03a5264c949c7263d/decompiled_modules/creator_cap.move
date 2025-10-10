module 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::creator_cap {
    struct CreatorCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : CreatorCap {
        CreatorCap{id: 0x2::object::new(arg0)}
    }

    public(friend) fun destroy(arg0: CreatorCap) {
        let CreatorCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

