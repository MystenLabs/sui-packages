module 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::cap_ylds_admin {
    struct YldsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun get_id(arg0: &YldsAdminCap) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun new_ylds_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : YldsAdminCap {
        YldsAdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

