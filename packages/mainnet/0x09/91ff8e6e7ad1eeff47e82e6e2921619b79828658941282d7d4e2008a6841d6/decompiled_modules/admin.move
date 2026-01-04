module 0x991ff8e6e7ad1eeff47e82e6e2921619b79828658941282d7d4e2008a6841d6::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminRegistry has key {
        id: 0x2::object::UID,
        minted: bool,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminRegistry{
            id     : 0x2::object::new(arg0),
            minted : false,
        };
        0x2::transfer::share_object<AdminRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun mint_admin_cap_guarded(arg0: &mut AdminRegistry, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(!arg0.minted, 100);
        arg0.minted = true;
        AdminCap{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}

