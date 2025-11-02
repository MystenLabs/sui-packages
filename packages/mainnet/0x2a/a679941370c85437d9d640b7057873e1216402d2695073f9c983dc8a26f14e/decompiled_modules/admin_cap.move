module 0x2aa679941370c85437d9d640b7057873e1216402d2695073f9c983dc8a26f14e::admin_cap {
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

