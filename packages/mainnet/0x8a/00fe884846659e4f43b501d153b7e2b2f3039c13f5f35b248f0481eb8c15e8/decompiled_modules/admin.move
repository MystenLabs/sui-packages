module 0x8a00fe884846659e4f43b501d153b7e2b2f3039c13f5f35b248f0481eb8c15e8::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

