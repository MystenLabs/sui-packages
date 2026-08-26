module 0xdbf1d81ada0918a749fcd60b918e317ac90b2d704d212940e18508676c23b43e::nc {
    public fun nc(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: address, arg2: u8, arg3: u256, arg4: u8, arg5: u256) {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg2, arg1);
        assert!(v1 == arg3, 3);
        let (v2, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg4, arg1);
        assert!(v2 == arg5, 3);
    }

    // decompiled from Move bytecode v7
}

