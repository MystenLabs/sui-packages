module 0x21e7032ae20cbb5cdbd9f44994d7a1a983e5d48318e9b89dbc195595e548c823::access_control {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
    }

    struct AccessRegistry has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        admins: 0x2::table::Table<address, bool>,
    }

    public(friend) fun create_admin_cap(arg0: 0x2::object::ID, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id      : 0x2::object::new(arg2),
            form_id : arg0,
        };
        let v1 = AccessRegistry{
            id      : 0x2::object::new(arg2),
            form_id : arg0,
            admins  : 0x2::table::new<address, bool>(arg2),
        };
        0x2::table::add<address, bool>(&mut v1.admins, arg1, true);
        0x2::transfer::transfer<AdminCap>(v0, arg1);
        0x2::transfer::share_object<AccessRegistry>(v1);
    }

    public fun form_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.form_id
    }

    public fun grant_admin(arg0: &mut AccessRegistry, arg1: &AdminCap, arg2: address) {
        assert!(arg0.form_id == arg1.form_id, 0);
        if (!0x2::table::contains<address, bool>(&arg0.admins, arg2)) {
            0x2::table::add<address, bool>(&mut arg0.admins, arg2, true);
        };
    }

    public fun is_authorized(arg0: &AccessRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.admins, arg1)
    }

    public fun revoke_admin(arg0: &mut AccessRegistry, arg1: &AdminCap, arg2: address) {
        assert!(arg0.form_id == arg1.form_id, 0);
        if (0x2::table::contains<address, bool>(&arg0.admins, arg2)) {
            0x2::table::remove<address, bool>(&mut arg0.admins, arg2);
        };
    }

    // decompiled from Move bytecode v7
}

