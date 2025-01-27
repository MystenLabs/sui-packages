module 0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_admin_cap(arg0: &0x2::coin::TreasuryCap<0x7bae0b3b7b6c3da899fe3f4af95b7110633499c02b8c6945110d799d99deaa68::mpoints::MPOINTS>, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}

