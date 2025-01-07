module 0x5be427f69c3ff10e5d5eae6ab385f9f4a394154f1c3cef22f2f77424ed9c16a4::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

