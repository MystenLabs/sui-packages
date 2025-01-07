module 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun clone_cap_for_recipient(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(new_cap(arg2), arg1);
    }

    public entry fun destroy_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new_cap(arg0);
        0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::event::emit_admin_cap_created(0x2::object::id<AdminCap>(&v0));
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun new_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v6
}

