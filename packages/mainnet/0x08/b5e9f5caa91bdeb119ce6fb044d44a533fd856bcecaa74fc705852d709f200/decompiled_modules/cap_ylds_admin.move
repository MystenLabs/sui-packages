module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::cap_ylds_admin {
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

