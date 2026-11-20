module 0x5f1cf0ea211b9229f2b732df6bc809e28f6026fde74f5c27c6457f920c32c6da::account {
    public fun sync(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address, arg3: u256) {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, arg2);
        assert!(v1 >= arg3, 0);
    }

    // decompiled from Move bytecode v7
}

