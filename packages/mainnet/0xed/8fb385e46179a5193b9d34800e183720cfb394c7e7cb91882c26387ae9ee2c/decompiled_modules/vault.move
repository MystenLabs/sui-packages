module 0xed8fb385e46179a5193b9d34800e183720cfb394c7e7cb91882c26387ae9ee2c::vault {
    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        pool_id: 0x2::object::ID,
        sui_index: u8,
        usdc_index: u8,
    }

    public fun deposit<T0, T1>(arg0: &Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0x2::clock::Clock) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T0>(arg6, arg2, arg3, arg0.sui_index, arg1, arg4, arg5, &arg0.account_cap);
    }

    entry fun initialize<T0, T1>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Vault<T0, T1>{
            id          : 0x2::object::new(arg1),
            account_cap : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
            pool_id     : arg0,
            sui_index   : 0,
            usdc_index  : 1,
        };
        0x2::transfer::share_object<Vault<T0, T1>>(v0);
        0x2::object::id<Vault<T0, T1>>(&v0)
    }

    // decompiled from Move bytecode v6
}

