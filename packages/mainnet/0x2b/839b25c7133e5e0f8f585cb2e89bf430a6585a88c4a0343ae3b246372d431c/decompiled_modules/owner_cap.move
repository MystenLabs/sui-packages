module 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::owner_cap {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : OwnerCap {
        OwnerCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

