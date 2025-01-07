module 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::harvest {
    struct RewardsHarvestedEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        total_deposited_a: u64,
        total_borrowed_b: u64,
        aum_in_a: u64,
        total_lp_supply: u64,
    }

    public fun consume_harvest_deposit_receipt<T0, T1, T2>(arg0: &0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::VaultCap, arg1: &mut 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::Vault<T0, T1, T2>, arg2: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &0xce7e9b076229e914dc87900323fa122fb6869f39fda82b85770d1aa27f61ad8e::oracle::KriyaOracle, arg10: &0xdf3da4bcc7939caf6486ecc104e1cbd69f97f2025195d270649566301d15eb96::registry::CoinDecimalsRegistry, arg11: &0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::VaultAcl, arg12: &0x2::clock::Clock, arg13: &0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::version::Version, arg14: &mut 0x2::tx_context::TxContext) {
        0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::version::assert_current_version(arg13);
        0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, bool, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(arg2, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::access(arg11), b"is_harvest"), 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::error::invalid_flow_id());
        let v0 = 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::deposit::process_deposit_receipt<T0, T1, T2>(arg1, arg11, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg12, arg13, arg14);
        let (v1, v2) = 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::performance_fees<T0, T1, T2>(arg1);
        0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::collect_performance_fees<T0, T1, T2>(arg1, 0x2::coin::into_balance<T2>(0x2::coin::split<T2>(&mut v0, (((0x2::coin::value<T2>(&v0) as u128) * (v1 as u128) / (v2 as u128)) as u64), arg14)));
        0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::burn_vt<T0, T1, T2>(arg1, v0);
        let (v3, v4, v5) = 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::utils::calc_aum<T0, T1, T2>(arg1, arg4, arg5, arg9, arg10, arg3, arg12);
        let v6 = RewardsHarvestedEvent{
            vault_id          : 0x2::object::id<0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::Vault<T0, T1, T2>>(arg1),
            total_deposited_a : v4,
            total_borrowed_b  : v5,
            aum_in_a          : v3,
            total_lp_supply   : 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::total_vt_supply<T0, T1, T2>(arg1),
        };
        0x2::event::emit<RewardsHarvestedEvent>(v6);
    }

    public fun consume_harvest_receipt<T0, T1, T2>(arg0: &0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::VaultCap, arg1: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg2: &mut 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::Vault<T0, T1, T2>, arg3: &0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::VaultAcl, arg4: &0xfac036f8b889e6ca3fed666467ab40580193d6e27d3ae0a9fbd4305aa06d566b::acl::AggregatorAcl, arg5: &0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::version::Version, arg6: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::version::assert_current_version(arg5);
        0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::assert_vault_cap<T0, T1, T2>(arg2, arg0);
        let v0 = 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::access(arg3);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(&mut arg1, v0, b"flow_id") == 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::utils::harvest_flow_id(), 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::error::invalid_flow_id());
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(&mut arg1, v0, b"vault_id") == 0x2::object::id<0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::Vault<T0, T1, T2>>(arg2), 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::error::invalid_vault());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(&mut arg1, v0, b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(&mut arg1, v0, b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg1);
        let v1 = 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::deposit::get_deposit_receipt<T0, T1, T2>(arg2, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(&mut arg1, v0, b"funds"), arg3, arg4, arg5, arg6);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(&mut v1, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::access(arg3), b"is_harvest", true);
        v1
    }

    public fun harvest_base_asset<T0, T1, T2>(arg0: &0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::VaultCap, arg1: &mut 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::Vault<T0, T1, T2>, arg2: bool, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg6: &0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::VaultAcl, arg7: &0xfac036f8b889e6ca3fed666467ab40580193d6e27d3ae0a9fbd4305aa06d566b::acl::AggregatorAcl, arg8: &0x2::clock::Clock, arg9: &0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::version::Version, arg10: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::version::assert_current_version(arg9);
        0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        let v0 = if (arg2) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_supply()
        } else {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_borrow()
        };
        let v1 = if (arg2) {
            0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::a_index<T0, T1, T2>(arg1)
        } else {
            0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::b_index<T0, T1, T2>(arg1)
        };
        let v2 = 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::deposit::get_deposit_receipt<T0, T1, T2>(arg1, 0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T0>(arg8, arg4, arg5, arg3, v1, v0, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::account_cap<T0, T1, T2>(arg1)), arg10), arg6, arg7, arg9, arg10);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(&mut v2, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::access(arg6), b"vault_id", 0x2::object::id<0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::Vault<T0, T1, T2>>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(&mut v2, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::access(arg6), b"is_harvest", true);
        v2
    }

    public fun issue_harvest_receipt<T0, T1, T2, T3>(arg0: &0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::VaultCap, arg1: &mut 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::Vault<T0, T1, T2>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T3>, arg5: bool, arg6: &0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::VaultAcl, arg7: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg8: &0x2::clock::Clock, arg9: &0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::version::Version, arg10: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::version::assert_current_version(arg9);
        0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::assert_vault_cap<T0, T1, T2>(arg1, arg0);
        let v0 = if (arg5) {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_supply()
        } else {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::option_borrow()
        };
        let v1 = if (arg5) {
            0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::a_index<T0, T1, T2>(arg1)
        } else {
            0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::b_index<T0, T1, T2>(arg1)
        };
        let v2 = 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::get_swap_route<T0, T1, T2, T3>(arg1);
        let v3 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::access(arg6), 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg7)), arg10);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(&mut v3, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::access(arg6), b"flow_id", 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::utils::harvest_flow_id());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(&mut v3, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::access(arg6), b"vault_id", 0x2::object::id<0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::Vault<T0, T1, T2>>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T3>, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(&mut v3, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::access(arg6), b"funds", 0x2::coin::from_balance<T3>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T3>(arg8, arg3, arg4, arg2, v1, v0, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault::account_cap<T0, T1, T2>(arg1)), arg10));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(&mut v3, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::access(arg6), b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(&mut v3, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::access(arg6), b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::Access>(&mut v3, 0x2a4bd6f493ad0fed3c5ac89e7ec44d95ea8b9579f466d5123168fa25cc5d469d::vault_acl::access(arg6), (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v2) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v2));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v2);
        v3
    }

    // decompiled from Move bytecode v6
}

