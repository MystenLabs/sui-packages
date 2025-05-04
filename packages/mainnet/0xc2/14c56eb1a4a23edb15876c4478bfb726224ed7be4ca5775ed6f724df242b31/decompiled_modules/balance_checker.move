module 0xc214c56eb1a4a23edb15876c4478bfb726224ed7be4ca5775ed6f724df242b31::balance_checker {
    public entry fun verify_balance(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: address, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, arg2);
        assert!(v1 > arg3, 100);
    }

    // decompiled from Move bytecode v6
}

