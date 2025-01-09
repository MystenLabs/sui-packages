module 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version {
    struct CurrentVersion<phantom T0> has copy, drop, store {
        version: u64,
    }

    public fun assert_version<T0>(arg0: &0x2::object::UID, arg1: u64) {
        let v0 = *0x2::dynamic_field::borrow<vector<u8>, CurrentVersion<T0>>(arg0, b"version");
        assert!(v0.version == arg1, 0);
    }

    public fun init_version<T0>(arg0: &T0, arg1: &mut 0x2::object::UID, arg2: u64) {
        let v0 = CurrentVersion<T0>{version: arg2};
        0x2::dynamic_field::add<vector<u8>, CurrentVersion<T0>>(arg1, b"version", v0);
    }

    public fun migrate_version<T0>(arg0: &T0, arg1: &mut 0x2::object::UID, arg2: u64) {
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, CurrentVersion<T0>>(arg1, b"version");
        assert!(v0.version < arg2, 1);
        v0.version = arg2;
    }

    // decompiled from Move bytecode v6
}

