module 0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::config::new<INIT>(&arg0, arg1);
        0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::config::borrow_mut_id(&mut v0), arg1);
        0xe4183b7aab8293c85393f5d3f59f76e36d8ea7c65a30011229e92d223ee34681::config::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

