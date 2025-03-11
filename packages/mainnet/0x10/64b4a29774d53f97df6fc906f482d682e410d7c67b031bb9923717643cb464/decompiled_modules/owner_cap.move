module 0x1064b4a29774d53f97df6fc906f482d682e410d7c67b031bb9923717643cb464::owner_cap {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : OwnerCap {
        OwnerCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

