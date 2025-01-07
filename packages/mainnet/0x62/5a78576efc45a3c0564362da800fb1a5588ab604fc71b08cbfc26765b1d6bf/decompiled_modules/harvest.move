module 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::harvest {
    struct RewardsHarvestedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        total_deposited_a: u64,
        total_borrowed_b: u64,
        aum_in_a: u64,
        total_lp_supply: u64,
    }

    public fun consume_harvest_receipt_a<T0, T1, T2>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault::Vault<T0, T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::KriyaOracle, arg9: &0x31f55a770ae4b852c36992dec0e794ed846e3160b1993b023328d815b0bc16f6::registry::CoinDecimalsRegistry, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::VaultAcl, arg13: &0x2::clock::Clock, arg14: &0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::version::Version, arg15: &mut 0x2::tx_context::TxContext) {
        0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::version::assert_current_version(arg14);
        0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault::burn_vt<T0, T1, T2>(arg1, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::deposit::deposit_a<T0, T1, T2>(arg1, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::Access>(&mut arg0, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::access(arg12), b"funds"), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13, arg14, arg15));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::Access>(&mut arg0, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::access(arg12), b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::Access>(&mut arg0, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::access(arg12), b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg0);
        let (v0, v1, v2) = 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::utils::calc_aum<T0, T1, T2>(arg1, arg4, arg5, arg8, arg9, arg3, arg13);
        let v3 = RewardsHarvestedEvent{
            vault_id          : 0x2::object::id<0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault::Vault<T0, T1, T2>>(arg1),
            total_deposited_a : v1,
            total_borrowed_b  : v2,
            aum_in_a          : v0,
            total_lp_supply   : 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault::total_vt_supply<T0, T1, T2>(arg1),
        };
        0x2::event::emit<RewardsHarvestedEvent>(v3);
    }

    public fun consume_harvest_receipt_b<T0, T1, T2>(arg0: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg1: &mut 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault::Vault<T0, T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x659b624dfd09c631f9925e21dd6144a483b0530fc0fd8a5b620e5d7b88d1bccf::oracle::KriyaOracle, arg9: &0x31f55a770ae4b852c36992dec0e794ed846e3160b1993b023328d815b0bc16f6::registry::CoinDecimalsRegistry, arg10: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::VaultAcl, arg13: &0x2::clock::Clock, arg14: &0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::version::Version, arg15: &mut 0x2::tx_context::TxContext) {
        0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::version::assert_current_version(arg14);
        0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault::burn_vt<T0, T1, T2>(arg1, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::deposit::deposit_b<T0, T1, T2>(arg1, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::Access>(&mut arg0, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::access(arg12), b"funds"), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13, arg14, arg15));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::Access>(&mut arg0, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::access(arg12), b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::Access>(&mut arg0, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::access(arg12), b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg0);
        let (v0, v1, v2) = 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::utils::calc_aum<T0, T1, T2>(arg1, arg4, arg5, arg8, arg9, arg3, arg13);
        let v3 = RewardsHarvestedEvent{
            vault_id          : 0x2::object::id<0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault::Vault<T0, T1, T2>>(arg1),
            total_deposited_a : v1,
            total_borrowed_b  : v2,
            aum_in_a          : v0,
            total_lp_supply   : 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault::total_vt_supply<T0, T1, T2>(arg1),
        };
        0x2::event::emit<RewardsHarvestedEvent>(v3);
    }

    public fun issue_harvest_receipt<T0, T1, T2, T3>(arg0: &mut 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault::Vault<T0, T1, T2>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T3>, arg4: bool, arg5: &0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::VaultAcl, arg6: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg7: &0x2::clock::Clock, arg8: &0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::version::Version, arg9: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::version::assert_current_version(arg8);
        let v0 = if (arg4) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_supply()
        } else {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_borrow()
        };
        let v1 = if (arg4) {
            0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault::a_index<T0, T1, T2>(arg0)
        } else {
            0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault::b_index<T0, T1, T2>(arg0)
        };
        let v2 = 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault::get_swap_route<T0, T1, T2, T3>(arg0);
        let v3 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::Access>(0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::access(arg5), 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg6)), arg9);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T3>, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::Access>(&mut v3, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::access(arg5), b"funds", 0x2::coin::from_balance<T3>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T3>(arg7, arg2, arg3, arg1, v1, v0, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault::account_cap<T0, T1, T2>(arg0)), arg9));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::Access>(&mut v3, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::access(arg5), b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::Access>(&mut v3, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::access(arg5), b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::Access>(&mut v3, 0x625a78576efc45a3c0564362da800fb1a5588ab604fc71b08cbfc26765b1d6bf::vault_acl::access(arg5), (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v2));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v2);
        v3
    }

    // decompiled from Move bytecode v6
}

