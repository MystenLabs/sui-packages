module 0x16b4efa1647c753becc83fffdac16b9df0e81566a0bab3bc4b62a8299282311c::fishing_star {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FISHING_STAR has drop {
        dummy_field: bool,
    }

    public fun destroy_admin_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: FISHING_STAR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<FISHING_STAR>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun new_admin_cap(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x2::package::from_package<FISHING_STAR>(arg0), 1);
        AdminCap{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}

