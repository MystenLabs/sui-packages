module 0x6b8c23a9b5540d8f5987263ce80301debdf026540d7f30d031c3ec45d9d5504d::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

