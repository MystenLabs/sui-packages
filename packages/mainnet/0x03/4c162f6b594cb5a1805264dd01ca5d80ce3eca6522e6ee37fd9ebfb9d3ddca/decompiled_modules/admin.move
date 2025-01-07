module 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::admin {
    struct ADMIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        epoch: u64,
    }

    struct SuperadminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun destroy_admin_cap(arg0: AdminCap) {
        let AdminCap {
            id    : v0,
            epoch : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SuperadminCap{id: 0x2::object::new(arg1)};
        let v1 = internal_create_admin_cap(arg1);
        0x2::transfer::transfer<SuperadminCap>(v0, @0xde0053243f3226649701a7fe2c3988be11941bf3ff3535f3c8c5bf32fc600220);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun internal_create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{
            id    : 0x2::object::new(arg0),
            epoch : 0x2::tx_context::epoch(arg0),
        }
    }

    entry fun superadmin_issue_admin_cap(arg0: &SuperadminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(internal_create_admin_cap(arg2), arg1);
    }

    public(friend) fun verify_admin_cap(arg0: &AdminCap, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.epoch == 0x2::tx_context::epoch(arg1), 1);
    }

    // decompiled from Move bytecode v6
}

