module 0x1bc35674b8c04958ec76680ef7d8baa2e1bae8b9f1d4ba6d85f6cc9838e79a14::guard {
    public fun assert_navi_target(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address, arg2: u8, arg3: u256, arg4: u8, arg5: u256) {
        let v0 = if (arg5 > 0) {
            if (arg3 > 0) {
                arg2 != arg4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 64003);
        let (_, v2) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg4, arg1);
        let (v3, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg2, arg1);
        assert!(v2 >= arg5, 64001);
        assert!(v3 >= arg3, 64002);
    }

    // decompiled from Move bytecode v7
}

