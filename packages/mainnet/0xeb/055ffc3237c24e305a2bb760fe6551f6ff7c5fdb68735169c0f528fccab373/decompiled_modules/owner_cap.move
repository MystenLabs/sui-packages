module 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::owner_cap {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : OwnerCap {
        OwnerCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

