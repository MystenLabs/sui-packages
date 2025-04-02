module 0x9ef2c50a05c86309f2fa7b2c504020ceb242f762cdc525e3ba34dbd12076c5d0::routertest {
    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
    }

    struct ChangeAdminEvent has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    entry fun change_admin(arg0: &mut Version, arg1: address) {
        arg0.admin = arg1;
        let v0 = ChangeAdminEvent{
            old_admin : arg0.admin,
            new_admin : arg0.admin,
        };
        0x2::event::emit<ChangeAdminEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id      : 0x2::object::new(arg0),
            version : 0,
            admin   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Version>(v0);
    }

    // decompiled from Move bytecode v6
}

