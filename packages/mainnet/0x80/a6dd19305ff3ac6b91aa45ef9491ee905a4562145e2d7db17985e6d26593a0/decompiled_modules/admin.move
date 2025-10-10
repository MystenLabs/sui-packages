module 0x80a6dd19305ff3ac6b91aa45ef9491ee905a4562145e2d7db17985e6d26593a0::admin {
    struct AdminRegistry has store, key {
        id: 0x2::object::UID,
        super_admin: address,
        admins: 0x2::table::Table<address, bool>,
    }

    struct AdminAdded has copy, drop {
        admin: address,
    }

    struct AdminRemoved has copy, drop {
        admin: address,
    }

    public entry fun add_admin(arg0: &mut AdminRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.super_admin, 0);
        assert!(!0x2::table::contains<address, bool>(&arg0.admins, arg1), 1);
        0x2::table::add<address, bool>(&mut arg0.admins, arg1, true);
        let v0 = AdminAdded{admin: arg1};
        0x2::event::emit<AdminAdded>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminRegistry{
            id          : 0x2::object::new(arg0),
            super_admin : v0,
            admins      : 0x2::table::new<address, bool>(arg0),
        };
        0x2::table::add<address, bool>(&mut v1.admins, v0, true);
        0x2::transfer::share_object<AdminRegistry>(v1);
    }

    public fun is_admin(arg0: &AdminRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.admins, arg1)
    }

    public fun is_super_admin(arg0: &AdminRegistry, arg1: address) : bool {
        arg1 == arg0.super_admin
    }

    public entry fun remove_admin(arg0: &mut AdminRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.super_admin, 0);
        assert!(arg1 != arg0.super_admin, 0);
        assert!(0x2::table::contains<address, bool>(&arg0.admins, arg1), 2);
        0x2::table::remove<address, bool>(&mut arg0.admins, arg1);
        let v0 = AdminRemoved{admin: arg1};
        0x2::event::emit<AdminRemoved>(v0);
    }

    // decompiled from Move bytecode v6
}

