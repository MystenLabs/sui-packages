module 0x4f3d909cef5abe4fd4a39d58293acbb250cb0700a23bed27e853be2e9cada7da::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun create_admin_cap<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 9223372200063533057);
        AdminCap{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}

