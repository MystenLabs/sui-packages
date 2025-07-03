module 0x7304f71f782b1058f79732f6c937256bd06830bd9ea6258b05063f150e869a3f::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

