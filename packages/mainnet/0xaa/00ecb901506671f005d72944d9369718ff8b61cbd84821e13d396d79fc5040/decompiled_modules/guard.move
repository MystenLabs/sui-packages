module 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::guard {
    public fun assert_bite_still_open<T0, T1>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: u8, arg3: address, arg4: u64, arg5: u64) {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, arg3);
        let (_, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1);
        assert!(0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::math::current_balance(v1, v3) >= (arg4 as u256), 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::already_bitten());
        let (v4, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg2, arg3);
        let (v6, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg2);
        assert!(0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::math::current_balance(v4, v6) >= (arg5 as u256), 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::collateral_gone());
    }

    public fun bite_balances(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: u8, arg2: u8, arg3: address) : (u256, u256) {
        let (_, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg1, arg3);
        let (_, v3) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg1);
        let (v4, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(arg0, arg2, arg3);
        let (v6, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_index(arg0, arg2);
        (0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::math::current_balance(v1, v3), 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::math::current_balance(v4, v6))
    }

    // decompiled from Move bytecode v7
}

