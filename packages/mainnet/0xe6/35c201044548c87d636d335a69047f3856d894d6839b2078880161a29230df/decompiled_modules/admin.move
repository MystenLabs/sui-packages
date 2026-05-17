module 0x143bd9071ea4f375d4321f2eb424d083b74a34388710e2cc7fbc31a9c45f1793::admin {
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
            minted : true,
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

    // decompiled from Move bytecode v7
}

