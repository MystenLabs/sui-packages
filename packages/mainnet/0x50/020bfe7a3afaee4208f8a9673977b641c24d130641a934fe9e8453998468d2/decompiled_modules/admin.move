module 0x50020bfe7a3afaee4208f8a9673977b641c24d130641a934fe9e8453998468d2::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

