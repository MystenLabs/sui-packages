module 0xbdc7b62f56a651fb7801798e6b3746097bb7dac84db7b20e5015d95579b2b7e9::admin {
    struct AdminAccess has key {
        id: 0x2::object::UID,
        admin_1: address,
        dex: address,
        account: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        admin_id: u8,
    }

    public fun assert_initialised(arg0: &AdminAccess) {
        assert!(arg0.admin_1 != @0x0, 0);
        assert!(arg0.dex != @0x123, 0);
    }

    public fun get_addresses(arg0: &AdminAccess) : (address, address, address) {
        assert_initialised(arg0);
        (arg0.admin_1, arg0.dex, arg0.account)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminAccess{
            id      : 0x2::object::new(arg0),
            admin_1 : @0x0,
            dex     : @0x123,
            account : @0x123,
        };
        0x2::transfer::share_object<AdminAccess>(v0);
        let v1 = AdminCap{
            id       : 0x2::object::new(arg0),
            admin_id : 1,
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = AdminCap{
            id       : 0x2::object::new(arg0),
            admin_id : 2,
        };
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun set_account_address(arg0: &mut AdminAccess, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin_id == 1 || arg1.admin_id == 2, 0);
        arg0.account = arg2;
    }

    public fun set_dex_address(arg0: &mut AdminAccess, arg1: AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin_id == 1 || arg1.admin_id == 2, 0);
        arg0.dex = arg2;
        0x2::transfer::transfer<AdminCap>(arg1, arg2);
    }

    public fun update_address(arg0: &mut AdminAccess, arg1: AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin_id == 1 || arg1.admin_id == 2, 0);
        arg0.admin_1 = arg2;
        0x2::transfer::transfer<AdminCap>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

