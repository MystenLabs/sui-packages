module 0x7a018d67667ebbe9980fdfb39301243f315d30796c5879c2f21d5a9fa64d9273::admin_cap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun init_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public(friend) fun transfer_to(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

