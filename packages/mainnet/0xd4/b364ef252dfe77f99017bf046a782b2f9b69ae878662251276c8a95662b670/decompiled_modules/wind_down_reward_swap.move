module 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::wind_down_reward_swap {
    struct RewardSettledEvent has copy, drop {
        vault_id: 0x2::object::ID,
        harvest_cap_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_amount: u64,
        sender: address,
    }

    public fun consume_finalized_reward_swap<T0: store, T1, T2, T3>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap, arg1: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg2: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg3: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::VaultAcl, arg4: u64, arg5: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg5);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_assert_harvest_finalized<T0, T1, T2>(arg2, arg0, arg6);
        let (v0, v1) = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::take_migration_reward_output<T0, T1, T2>(arg3, arg2, arg0, arg1, arg6);
        let v2 = v1;
        let v3 = 0x2::coin::value<T0>(&v2);
        assert!(v3 >= arg4, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::slippage_exceeded());
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_join_settled_reward_a<T0, T1, T2>(arg2, arg0, 0x2::coin::into_balance<T0>(v2), arg6);
        let v4 = RewardSettledEvent{
            vault_id       : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg2),
            harvest_cap_id : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap>(arg0),
            reward_type    : 0x1::type_name::get<T3>(),
            input_amount   : v0,
            output_amount  : v3,
            sender         : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<RewardSettledEvent>(v4);
    }

    public fun consume_finalized_reward_swap_v2<T0, T1, T2, T3>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap, arg1: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg2: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg3: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::VaultAcl, arg4: u64, arg5: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg5);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_assert_harvest_finalized<T0, T1, T2>(arg2, arg0, arg6);
        let (v0, v1) = 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::take_migration_reward_output<T0, T1, T2>(arg3, arg2, arg0, arg1, arg6);
        let v2 = v1;
        let v3 = 0x2::coin::value<T0>(&v2);
        assert!(v3 >= arg4, 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::error::slippage_exceeded());
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_join_settled_reward_a_v2<T0, T1, T2>(arg2, arg0, 0x2::coin::into_balance<T0>(v2), arg6);
        let v4 = RewardSettledEvent{
            vault_id       : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>>(arg2),
            harvest_cap_id : 0x2::object::id<0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap>(arg0),
            reward_type    : 0x1::type_name::get<T3>(),
            input_amount   : v0,
            output_amount  : v3,
            sender         : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<RewardSettledEvent>(v4);
    }

    public fun issue_stored_reward_swap<T0, T1, T2, T3>(arg0: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg1: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::HarvestCap, arg2: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::VaultAcl, arg3: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg4: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg4);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_assert_harvest_finalized<T0, T1, T2>(arg0, arg1, arg5);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault_acl::issue_migration_reward_receipt<T0, T1, T2, T3>(arg2, arg0, arg1, 0x2::coin::from_balance<T3>(0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_take_wind_down_reward<T0, T1, T2, T3>(arg0, arg1, arg5), arg5), arg3, arg5)
    }

    public fun set_finalized_reward_route<T0, T1, T2, T3>(arg0: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::VaultCap, arg1: &mut 0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: &0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::Version) {
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::version::assert_current_version(arg3);
        0x2c45b38a7eda6a058a4461ac4af4d547edae24abbc833da8116bc11a408a4aed::vault::migration_set_reward_route<T0, T1, T2, T3>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

