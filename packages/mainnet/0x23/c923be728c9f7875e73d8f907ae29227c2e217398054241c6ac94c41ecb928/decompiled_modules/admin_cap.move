module 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::admin_cap {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_and_transfer_admin_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_admin_cap(arg1);
        0x2::transfer::public_transfer<AdminCap>(v0, arg0);
        0x2::object::id<AdminCap>(&v0)
    }

    public(friend) fun get_admin_cap_id(arg0: &AdminCap) : 0x2::object::ID {
        0x2::object::id<AdminCap>(arg0)
    }

    public(friend) fun new_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

