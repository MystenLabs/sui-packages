module 0x10b30bb10ebc6b2fd3c9b435946c6a96745c10d3e3dd83a0778d378211c02bfc::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

