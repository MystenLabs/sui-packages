module 0x6f8b6fc1ab2cbc73e445f269f7d25625077a85466b3628c4ca597cdd27f9ec3::routertest {
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

