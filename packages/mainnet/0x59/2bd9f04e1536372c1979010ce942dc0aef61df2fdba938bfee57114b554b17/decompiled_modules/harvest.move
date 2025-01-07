module 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::harvest {
    struct RewardsHarvestedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        total_deposited_a: u64,
        total_borrowed_b: u64,
        aum_in_a: u64,
        total_lp_supply: u64,
    }

    public fun consume_harvest_receipt_a<T0, T1, T2>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::Vault<T0, T1, T2>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg9: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: &0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::VaultAcl, arg12: &0x2::clock::Clock, arg13: &0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::version::Version, arg14: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg15: &mut 0x2::tx_context::TxContext) {
        0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::version::assert_current_version(arg13);
        0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::burn_vt<T0, T1, T2>(arg1, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::deposit::deposit_a<T0, T1, T2>(arg1, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::Access>(&mut arg0, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::access(arg11), b"funds"), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12, arg13, arg14, arg15));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::Access>(&mut arg0, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::access(arg11), b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::Access>(&mut arg0, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::access(arg11), b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg0);
        let (v0, v1, v2) = 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::utils::calc_aum<T0, T1, T2>(arg1, arg4, arg5, arg8, arg9, arg3, arg12);
        let v3 = RewardsHarvestedEvent{
            vault_id          : 0x2::object::id<0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::Vault<T0, T1, T2>>(arg1),
            total_deposited_a : v1,
            total_borrowed_b  : v2,
            aum_in_a          : v0,
            total_lp_supply   : 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::total_vt_supply<T0, T1, T2>(arg1),
        };
        0x2::event::emit<RewardsHarvestedEvent>(v3);
    }

    public fun consume_harvest_receipt_b<T0, T1, T2>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::Vault<T0, T1, T2>, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T1, T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg9: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: &0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::VaultAcl, arg12: &0x2::clock::Clock, arg13: &0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::version::Version, arg14: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg15: &mut 0x2::tx_context::TxContext) {
        0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::version::assert_current_version(arg13);
        0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::burn_vt<T0, T1, T2>(arg1, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::deposit::deposit_b<T0, T1, T2>(arg1, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::Access>(&mut arg0, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::access(arg11), b"funds"), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12, arg13, arg14, arg15));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::Access>(&mut arg0, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::access(arg11), b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::Access>(&mut arg0, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::access(arg11), b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg0);
        let (v0, v1, v2) = 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::utils::calc_aum<T0, T1, T2>(arg1, arg4, arg5, arg8, arg9, arg3, arg12);
        let v3 = RewardsHarvestedEvent{
            vault_id          : 0x2::object::id<0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::Vault<T0, T1, T2>>(arg1),
            total_deposited_a : v1,
            total_borrowed_b  : v2,
            aum_in_a          : v0,
            total_lp_supply   : 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::total_vt_supply<T0, T1, T2>(arg1),
        };
        0x2::event::emit<RewardsHarvestedEvent>(v3);
    }

    public fun harvest_base_asset<T0, T1, T2>(arg0: &mut 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::Vault<T0, T1, T2>, arg1: bool, arg2: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg9: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg10: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg11: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg12: &0x2::clock::Clock, arg13: &0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::version::Version, arg14: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg15: &mut 0x2::tx_context::TxContext) {
        0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::version::assert_current_version(arg13);
        let v0 = if (arg1) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_supply()
        } else {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_borrow()
        };
        let v1 = if (arg1) {
            0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::a_index<T0, T1, T2>(arg0)
        } else {
            0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::b_index<T0, T1, T2>(arg0)
        };
        0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::burn_vt<T0, T1, T2>(arg0, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::deposit::deposit_a<T0, T1, T2>(arg0, 0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T0>(arg12, arg7, arg8, arg3, v1, v0, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::account_cap<T0, T1, T2>(arg0)), arg15), arg2, arg3, arg4, arg5, arg6, arg7, arg9, arg10, arg11, arg12, arg13, arg14, arg15));
        let (v2, v3, v4) = 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::utils::calc_aum<T0, T1, T2>(arg0, arg4, arg5, arg9, arg10, arg3, arg12);
        let v5 = RewardsHarvestedEvent{
            vault_id          : 0x2::object::id<0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::Vault<T0, T1, T2>>(arg0),
            total_deposited_a : v3,
            total_borrowed_b  : v4,
            aum_in_a          : v2,
            total_lp_supply   : 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<RewardsHarvestedEvent>(v5);
    }

    public fun issue_harvest_receipt<T0, T1, T2, T3>(arg0: &mut 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::Vault<T0, T1, T2>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T3>, arg4: bool, arg5: &0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::VaultAcl, arg6: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg7: &0x2::clock::Clock, arg8: &0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::version::Version, arg9: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::version::assert_current_version(arg8);
        let v0 = if (arg4) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_supply()
        } else {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_borrow()
        };
        let v1 = if (arg4) {
            0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::a_index<T0, T1, T2>(arg0)
        } else {
            0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::b_index<T0, T1, T2>(arg0)
        };
        let v2 = 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::get_swap_route<T0, T1, T2, T3>(arg0);
        let v3 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::Access>(0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::access(arg5), 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg6)), arg9);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T3>, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::Access>(&mut v3, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::access(arg5), b"funds", 0x2::coin::from_balance<T3>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T3>(arg7, arg2, arg3, arg1, v1, v0, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault::account_cap<T0, T1, T2>(arg0)), arg9));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::Access>(&mut v3, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::access(arg5), b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::Access>(&mut v3, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::access(arg5), b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::Access>(&mut v3, 0x592bd9f04e1536372c1979010ce942dc0aef61df2fdba938bfee57114b554b17::vault_acl::access(arg5), (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v2));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v2);
        v3
    }

    // decompiled from Move bytecode v6
}

