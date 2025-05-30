module 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::harvest_navi {
    struct HarvestEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_amount: u64,
    }

    public fun consume_receipt<T0, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg7: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Acl, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::is_whitelisted_manager(arg0, 0x2::tx_context::sender(arg9)), 69);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg6, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg7), b"vault_id") == 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1), 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg6, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg7), b"current_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg6, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg7), b"final_index");
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::burn(arg6);
        let v0 = 0x2::coin::into_balance<T0>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut arg6, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg7), b"funds"));
        let (v1, v2) = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::performance_fees<T0, T1>(arg1);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::collect_performance_fees<T0, T1>(arg1, 0x2::balance::split<T0>(&mut v0, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::utils::safe_mul_div(0x2::balance::value<T0>(&v0), v1, v2)));
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposit<T0, T1>(arg1, v0, arg2, arg3, arg4, arg5, arg8, arg9);
        let v3 = HarvestEvent{
            vault_id      : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1),
            reward_amount : 0x2::balance::value<T0>(&v0),
        };
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::event::emit<HarvestEvent>(v3);
    }

    public fun get_receipt<T0, T1, T2>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T2>, arg5: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Acl, arg6: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        assert!(0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::is_whitelisted_manager(arg0, 0x2::tx_context::sender(arg8)), 69);
        let v0 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::get_swap_route<T0, T1, T2>(arg1);
        let v1 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg5), 0x1::option::some<0x2::object::ID>(0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::access_id(arg6)), arg8);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v1, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg5), b"vault_id", 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::coin::Coin<T2>, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v1, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg5), b"funds", 0x2::coin::from_balance<T2>(0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::claim_rewards<T0, T1, T2>(arg1, arg2, arg3, arg4, arg7), arg8));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v1, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg5), b"current_index", 0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v1, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg5), b"final_index", ((0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v0) - 1) as u8));
        while (!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v0)) {
            0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<u8, 0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::Access>(&mut v1, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::acl::access(arg5), (0x1::vector::length<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&v0) as u8), 0x1::vector::pop_back<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&mut v0));
        };
        0x1::vector::destroy_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(v0);
        v1
    }

    public fun harvest_base<T0, T1>(arg0: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::ManageCap, arg1: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::admin::is_whitelisted_manager(arg0, 0x2::tx_context::sender(arg8)), 69);
        let v0 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::claim_rewards<T0, T1, T0>(arg1, arg2, arg5, arg6, arg7);
        let (v1, v2) = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::performance_fees<T0, T1>(arg1);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::collect_performance_fees<T0, T1>(arg1, 0x2::balance::split<T0>(&mut v0, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::utils::safe_mul_div(0x2::balance::value<T0>(&v0), v1, v2)));
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposit<T0, T1>(arg1, v0, arg2, arg3, arg4, arg5, arg7, arg8);
        let v3 = HarvestEvent{
            vault_id      : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg1),
            reward_amount : 0x2::balance::value<T0>(&v0),
        };
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::event::emit<HarvestEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

