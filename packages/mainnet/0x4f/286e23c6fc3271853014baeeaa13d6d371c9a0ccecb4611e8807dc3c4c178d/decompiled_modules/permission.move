module 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::permission {
    struct Permission has store, key {
        id: 0x2::object::UID,
        admin: address,
        address: 0x2::table::Table<address, bool>,
    }

    public fun add_address(arg0: &mut Permission, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        if (!0x2::table::contains<address, bool>(&arg0.address, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.address, arg1, true);
        };
    }

    public fun check_permission(arg0: &Permission, arg1: address) {
        assert!(0x2::table::contains<address, bool>(&arg0.address, arg1), 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Permission{
            id      : 0x2::object::new(arg0),
            admin   : 0x2::tx_context::sender(arg0),
            address : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<Permission>(v0);
    }

    public fun remove_address(arg0: &mut Permission, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        if (!0x2::table::contains<address, bool>(&arg0.address, arg1)) {
            0x2::table::remove<address, bool>(&mut arg0.address, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

