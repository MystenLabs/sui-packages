module 0x8f6e10afbf9d96b11f7aeef288065f0382d4abd145613c8604724748cfa210e8::collateral_switch {
    public fun switch<T0>(arg0: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::flash_loan::Config, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &mut 0x2::tx_context::TxContext, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &0x2::clock::Clock) {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_loan_with_ctx<T0>(arg0, arg1, 20, arg2);
        0x2::balance::destroy_zero<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::flash_repay_with_ctx<T0>(arg4, arg3, arg1, v1, v0, arg2));
    }

    // decompiled from Move bytecode v6
}

