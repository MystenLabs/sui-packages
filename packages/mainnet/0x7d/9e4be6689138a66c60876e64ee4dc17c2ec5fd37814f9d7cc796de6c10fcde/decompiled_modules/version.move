module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        current_version: u64,
    }

    entry fun admin_freeze(arg0: &mut Version, arg1: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg2: &0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg1, arg2);
        arg0.current_version = 0;
    }

    entry fun admin_update(arg0: &mut Version, arg1: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg2: &0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg1, arg2);
        assert!(arg0.current_version < 5, 1);
        arg0.current_version = 5;
    }

    public fun assert_latest(arg0: &Version) {
        assert!(arg0.current_version == 5, 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id              : 0x2::object::new(arg0),
            current_version : 5,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    // decompiled from Move bytecode v6
}

