module 0x8a8254708edcdf377d0a3505e7fbbf1c53ba37e5ef233270b3aa358a4aa6bba0::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_admin_cap<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 9223372200063533057);
        AdminCap{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}

