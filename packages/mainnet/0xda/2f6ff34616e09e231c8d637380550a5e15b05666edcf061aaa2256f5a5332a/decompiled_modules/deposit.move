module 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::deposit {
    struct DepositEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        user: address,
        deposit_amount: u64,
        lp_shares_minted: u64,
        total_deposited_a: u64,
        total_borrowed_b: u64,
        aum_in_a: u64,
        total_lp_supply: u64,
    }

    fun calc_vt_shares<T0, T1, T2>(arg0: &0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault::Vault<T0, T1, T2>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg4: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u64, arg7: &0x2::clock::Clock) : u64 {
        let v0 = 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault::total_vt_supply<T0, T1, T2>(arg0);
        if (v0 == 0) {
            return arg6
        };
        let (v1, _, _) = 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::utils::calc_aum<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        (((arg6 as u256) * (v0 as u256) / (v1 as u256)) as u64)
    }

    fun get_deposit_flash_swap_amount(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u256) * (((arg0 as u64) - 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault::leverage_scaling()) as u256) / (0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault::leverage_scaling() as u256)) as u64)
    }

    public fun get_deposit_receipt<T0, T1, T2>(arg0: &0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::VaultAcl, arg3: &0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::AggregatorAcl, arg4: &0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::version::assert_current_version(arg4);
        let v0 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::Access>(0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::access(arg2), 0x1::option::some<0x2::object::ID>(0x313b01d4468faa7b7b8940783622f141fbc1614adfe5cb12ac92764a3586a214::acl::access_id(arg3)), arg5);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::Access>(&mut v0, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::access(arg2), b"deposit_balance", 0x2::coin::into_balance<T0>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::Access>(&mut v0, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::access(arg2), b"amount", get_deposit_flash_swap_amount(0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault::leverage<T0, T1, T2>(arg0), 0x2::coin::value<T0>(&arg1)));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::Access>(&mut v0, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::access(arg2), b"input_type", 0x1::type_name::get<T1>());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::Access>(&mut v0, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::access(arg2), b"fix_input", false);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::Access>(&mut v0, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::access(arg2), b"slippage", 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault::slippage<T0, T1, T2>(arg0));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::Access>(&mut v0, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::access(arg2), b"pool_id", 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault::pool_id<T0, T1, T2>(arg0));
        v0
    }

    public fun process_deposit_receipt<T0, T1, T2>(arg0: &mut 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault::Vault<T0, T1, T2>, arg1: &0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::VaultAcl, arg2: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg10: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg11: &0x2::clock::Clock, arg12: &0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::version::Version, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::version::assert_current_version(arg12);
        let v0 = 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::access(arg1);
        let v1 = 0x2::coin::from_balance<T0>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T0>, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::Access>(arg2, v0, b"deposit_balance"), arg13);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = calc_vt_shares<T0, T1, T2>(arg0, arg4, arg5, arg9, arg10, arg3, v2, arg11);
        0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T0>, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::Access>(arg2, v0, b"funds"), arg13));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T1>, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::Access>(arg2, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::access(arg1), b"funds", 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault::deposit<T0, T1, T2>(arg0, v1, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault_acl::Access>(arg2, v0, b"repay_amount"), arg3, arg4, arg5, arg6, arg7, arg8, arg11));
        let v4 = 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault::mint_vt<T0, T1, T2>(arg0, v3, arg13);
        let (v5, v6, v7) = 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::utils::calc_aum<T0, T1, T2>(arg0, arg4, arg5, arg9, arg10, arg3, arg11);
        let v8 = DepositEvent{
            vault_id          : 0x2::object::id<0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault::Vault<T0, T1, T2>>(arg0),
            user              : 0x2::tx_context::sender(arg13),
            deposit_amount    : v2,
            lp_shares_minted  : 0x2::coin::value<T2>(&v4),
            total_deposited_a : v6,
            total_borrowed_b  : v7,
            aum_in_a          : v5,
            total_lp_supply   : 0xda2f6ff34616e09e231c8d637380550a5e15b05666edcf061aaa2256f5a5332a::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<DepositEvent>(v8);
        v4
    }

    // decompiled from Move bytecode v6
}

