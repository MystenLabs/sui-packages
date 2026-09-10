module 0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        epoch: u64,
    }

    entry fun delete_admin_cap(arg0: AdminCap) {
        assert!(!is_super(&arg0), 4002);
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

    fun is_super(arg0: &AdminCap) : bool {
        arg0.epoch == 0
    }

    public fun mint_temp_admin_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_super(arg0), 4002);
        assert!(0x2::tx_context::epoch(arg2) > 0, 4003);
        let v0 = AdminCap{
            id    : 0x2::object::new(arg2),
            epoch : 0x2::tx_context::epoch(arg2),
        };
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public fun verify(arg0: &AdminCap, arg1: &0x2::tx_context::TxContext) {
        if (!is_super(arg0)) {
            assert!(arg0.epoch == 0x2::tx_context::epoch(arg1), 4001);
        };
    }

    public fun verify_super(arg0: &AdminCap) {
        assert!(is_super(arg0), 4002);
    }

    // decompiled from Move bytecode v7
}

