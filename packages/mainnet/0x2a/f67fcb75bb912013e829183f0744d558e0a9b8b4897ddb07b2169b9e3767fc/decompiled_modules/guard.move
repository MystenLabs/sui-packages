module 0xd9b8eb8513176a9b414964be21402901074be8c873680aa7bdb1365d944405d4::guard {
    public fun assert_navi_debt(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, arg2);
        assert!(v1 >= arg3, 1);
    }

    // decompiled from Move bytecode v7
}

