module 0x695f612a1ee9268d25ca5c03e705819a285ff0c5b4f7720fc75a00cb8c6f3b63::owner_cap {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : OwnerCap {
        OwnerCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

