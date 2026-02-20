module 0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::new<INIT>(&arg0, arg1);
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::authority::create_package_admin_cap_and_keep<INIT>(&arg0, 0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::borrow_mut_id(&mut v0), arg1);
        let v1 = 0;
        while (v1 < 0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::storage_count(&v0)) {
            0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::storage::share(0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::storage::new_from_index(&mut v0, v1));
            v1 = v1 + 1;
        };
        0xb66ba767148e49fafdb21da1c77754704c4b7a8f560c1b8a5a464046eedee2b5::config::share(v0);
        0x2::package::claim_and_keep<INIT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

