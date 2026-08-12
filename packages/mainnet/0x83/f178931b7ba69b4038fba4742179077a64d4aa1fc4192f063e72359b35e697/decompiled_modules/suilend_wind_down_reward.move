module 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_wind_down_reward {
    struct RewardStoredEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        total_stored: u64,
    }

    struct RewardClaimedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct RewardSettledEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        input_amount: u64,
        output_amount: u64,
        final_assets: u64,
    }

    fun assert_manager(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::admin::ManageCap, arg1: &0x2::tx_context::TxContext) {
        assert!(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::admin::is_whitelisted_manager(arg0, 0x2::tx_context::sender(arg1)), 209);
    }

    public fun claim_stored_reward_v2<T0, T1, T2, T3, T4>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::admin::ManageCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_manager(arg0, arg2);
        let v0 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_take_reward_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>, T4>(arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T4>>(0x2::coin::from_balance<T4>(v0, arg2), 0x2::tx_context::sender(arg2));
        let v1 = RewardClaimedEvent{
            vault_id    : 0x2::object::id<0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>>(arg1),
            reward_type : 0x1::type_name::get<T4>(),
            amount      : 0x2::balance::value<T4>(&v0),
            recipient   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RewardClaimedEvent>(v1);
    }

    public fun collect_base_reward_v2<T0, T1, T2, T3>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::admin::ManageCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg3: u64, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_manager(arg0, arg7);
        let v0 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_claim_rewards_from_reserve_v2<T0, T1, T3, T0>(arg0, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_protocol_config_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg1), arg2, arg3, arg4, arg5, arg6, arg7);
        store_reward<T0, T1, T2, T3, T0>(arg1, v0, arg7);
    }

    public fun collect_reward_v2<T0, T1, T2, T3, T4>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::admin::ManageCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T3>, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_manager(arg0, arg8);
        let v0 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_protocol_config_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg1);
        let v1 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_claim_rewards_from_reserve_v2<T0, T1, T3, T4>(arg0, v0, arg2, arg3, arg4, arg5, arg7, arg8);
        0x2::balance::join<T4>(&mut v1, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::migration_claim_cranked_rewards_v2<T0, T1, T3, T4>(arg0, v0, arg2, arg6, arg7, arg8));
        store_reward<T0, T1, T2, T3, T4>(arg1, v1, arg8);
    }

    public fun consume_finalized_reward_swap_v2<T0, T1, T2, T3>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::admin::ManageCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::Acl, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert_manager(arg0, arg5);
        let (v0, v1, v2) = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::take_migration_reward_output<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg3, arg1, arg2, arg5);
        let v3 = v2;
        let v4 = 0x2::coin::value<T0>(&v3);
        assert!(v4 >= arg4, 207);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_join_settled_reward_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg1, 0x2::coin::into_balance<T0>(v3), arg5);
        let v5 = RewardSettledEvent{
            vault_id      : 0x2::object::id<0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>>(arg1),
            reward_type   : v0,
            input_amount  : v1,
            output_amount : v4,
            final_assets  : 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::final_assets_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg1),
        };
        0x2::event::emit<RewardSettledEvent>(v5);
    }

    public fun issue_stored_reward_swap_v2<T0, T1, T2, T3, T4>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::admin::ManageCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::Acl, arg3: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg4: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        assert_manager(arg0, arg4);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::acl::issue_migration_reward_receipt<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>, T4>(arg2, arg1, 0x2::coin::from_balance<T4>(0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_take_reward_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>, T4>(arg1, arg4), arg4), 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_reward_route_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>, T4>(arg1, arg4), arg3, arg4)
    }

    public fun set_finalized_reward_route_v2<T0, T1, T2, T3, T4>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::version::VersionCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>) {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_set_reward_route_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>, T4>(arg0, arg1, arg2);
    }

    public fun settle_stored_base_reward_v2<T0, T1, T2, T3>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::admin::ManageCap, arg1: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg2: &0x2::tx_context::TxContext) {
        assert_manager(arg0, arg2);
        let v0 = 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_take_reward_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>, T0>(arg1, arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_join_settled_reward_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg1, v0, arg2);
        let v2 = RewardSettledEvent{
            vault_id      : 0x2::object::id<0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>>(arg1),
            reward_type   : 0x1::type_name::get<T0>(),
            input_amount  : v1,
            output_amount : v1,
            final_assets  : 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::final_assets_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>(arg1),
        };
        0x2::event::emit<RewardSettledEvent>(v2);
    }

    fun store_reward<T0, T1, T2, T3, T4>(arg0: &mut 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>, arg1: 0x2::balance::Balance<T4>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T4>(&arg1);
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::migration_store_reward_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>, T4>(arg0, arg1, arg2);
        if (v0 == 0) {
            return
        };
        let v1 = RewardStoredEvent{
            vault_id     : 0x2::object::id<0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>>(arg0),
            reward_type  : 0x1::type_name::get<T4>(),
            amount       : v0,
            total_stored : 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::stored_wind_down_reward_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>, T4>(arg0),
        };
        0x2::event::emit<RewardStoredEvent>(v1);
    }

    public fun stored_reward_balance_v2<T0, T1, T2, T3, T4>(arg0: &0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::Vault<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>>) : u64 {
        0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::vault::stored_wind_down_reward_v2<T0, T1, T2, 0x21c4cc0011cda95bd52e335e7f9866a83308e1aa8afd0d2c75d8700ce1b0a16f::suilend_config::SuilendConfig<T0, T1, T3>, T4>(arg0)
    }

    // decompiled from Move bytecode v7
}

