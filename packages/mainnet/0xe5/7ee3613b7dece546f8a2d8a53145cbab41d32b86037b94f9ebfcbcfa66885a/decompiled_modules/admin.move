module 0xe57ee3613b7dece546f8a2d8a53145cbab41d32b86037b94f9ebfcbcfa66885a::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_admin_cap<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 9223372200063533057);
        AdminCap{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}

