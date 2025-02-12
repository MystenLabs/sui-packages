module 0xa99b8c7b9bda734670e11b9eb549063fa6e96b34485fee62010d04d07b555d33::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_admin_cap<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 9223372200063533057);
        AdminCap{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}

