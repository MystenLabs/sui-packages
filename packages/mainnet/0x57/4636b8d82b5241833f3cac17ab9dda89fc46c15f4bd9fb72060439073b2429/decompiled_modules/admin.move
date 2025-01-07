module 0x574636b8d82b5241833f3cac17ab9dda89fc46c15f4bd9fb72060439073b2429::admin {
    struct AdminAccess has key {
        id: 0x2::object::UID,
        admin_1: address,
        admin_2: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin_id: u8,
    }

    public fun assert_initialised(arg0: &AdminAccess) {
        assert!(arg0.admin_1 != @0x0 && arg0.admin_2 != @0x0, 0);
    }

    public fun get_addresses(arg0: &AdminAccess) : (address, address) {
        assert_initialised(arg0);
        (arg0.admin_1, arg0.admin_2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminAccess{
            id      : 0x2::object::new(arg0),
            admin_1 : @0x0,
            admin_2 : @0x0,
        };
        0x2::transfer::share_object<AdminAccess>(v0);
        let v1 = AdminCap{
            id       : 0x2::object::new(arg0),
            admin_id : 1,
        };
        let v2 = AdminCap{
            id       : 0x2::object::new(arg0),
            admin_id : 2,
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun update_address(arg0: &mut AdminAccess, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1.admin_id == 1) {
            arg0.admin_1 = arg2;
        } else if (arg1.admin_id == 2) {
            arg0.admin_2 = arg2;
        };
    }

    // decompiled from Move bytecode v6
}

