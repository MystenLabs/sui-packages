module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        epoch: u64,
    }

    entry fun admin_promote_address(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(super_admin(arg0), 102);
        let v0 = AdminCap{
            id    : 0x2::object::new(arg2),
            epoch : 0x2::tx_context::epoch(arg2),
        };
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    entry fun delete_admin_cap(arg0: AdminCap) {
        assert!(!super_admin(&arg0), 103);
        let AdminCap {
            id    : v0,
            epoch : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id    : 0x2::object::new(arg0),
            epoch : 0,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun super_admin(arg0: &AdminCap) : bool {
        arg0.epoch == 0
    }

    public(friend) fun verify(arg0: &AdminCap, arg1: &0x2::tx_context::TxContext) {
        if (!super_admin(arg0)) {
            assert!(arg0.epoch == 0x2::tx_context::epoch(arg1), 101);
        };
    }

    // decompiled from Move bytecode v6
}

