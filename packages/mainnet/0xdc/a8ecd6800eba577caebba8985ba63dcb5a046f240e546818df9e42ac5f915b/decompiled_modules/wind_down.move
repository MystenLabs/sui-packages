module 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::wind_down {
    struct WindDownStartedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
    }

    struct LiquidityRemovedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        liquidity_removed: u128,
        amount_a: u64,
        amount_b: u64,
        sender: address,
    }

    struct PositionClosedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        sender: address,
    }

    struct WindDownFinalizedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        withdrawable_a: u64,
        withdrawable_b: u64,
        total_vault_coin_supply: u64,
        seed_vault_coin_balance: u64,
        circulating_vault_coin_supply: u64,
        sender: address,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        vault_coin_burnt: u64,
        withdraw_coin_a: u64,
        withdraw_coin_b: u64,
        sender: address,
    }

    public fun close_position<T0, T1, T2>(arg0: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::AdminCap, arg1: &mut 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::assert_current_version(arg4);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::assert_unwinding<T0, T1, T2>(arg1);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::check_pool_compatibility<T0, T1, T2>(arg1, arg2);
        assert!(0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::has_position<T0, T1, T2>(arg1), 0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::position_borrow<T0, T1, T2>(arg1)) == 0, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg3, arg2, 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::remove_position<T0, T1, T2>(arg1));
        let v0 = PositionClosedEvent{
            vault_id : 0x2::object::id<0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>>(arg1),
            sender   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<PositionClosedEvent>(v0);
    }

    public fun clear_zero_reward<T0, T1, T2, T3>(arg0: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::AdminCap, arg1: &mut 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg2: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::Version) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::assert_current_version(arg2);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::assert_unwinding<T0, T1, T2>(arg1);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::clear_zero_reward<T0, T1, T2, T3>(arg1);
    }

    public fun begin<T0, T1, T2>(arg0: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::AdminCap, arg1: &mut 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg2: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::assert_current_version(arg2);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::begin_wind_down<T0, T1, T2>(arg1);
        let v0 = WindDownStartedEvent{
            vault_id : 0x2::object::id<0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>>(arg1),
            sender   : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<WindDownStartedEvent>(v0);
    }

    public fun collect_fees<T0, T1, T2>(arg0: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::AdminCap, arg1: &mut 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::assert_current_version(arg4);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::assert_unwinding<T0, T1, T2>(arg1);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::collect::fees_internal<T0, T1, T2>(arg1, arg2, arg3, arg5);
    }

    public fun collect_reward<T0, T1, T2, T3>(arg0: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::AdminCap, arg1: &mut 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::assert_current_version(arg6);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::assert_unwinding<T0, T1, T2>(arg1);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::collect::rewards_internal<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public fun collect_reward_a<T0, T1, T2>(arg0: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::AdminCap, arg1: &mut 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::assert_current_version(arg6);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::assert_unwinding<T0, T1, T2>(arg1);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::collect::rewards_x_internal<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public fun collect_reward_b<T0, T1, T2>(arg0: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::AdminCap, arg1: &mut 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::assert_current_version(arg6);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::assert_unwinding<T0, T1, T2>(arg1);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::collect::rewards_y_internal<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public fun consume_reward_swap<T0, T1, T2, T3>(arg0: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::AdminCap, arg1: 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg2: &mut 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg3: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault_acl::VaultAcl, arg4: u64, arg5: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::Version) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::assert_current_version(arg5);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::assert_unwinding<T0, T1, T2>(arg2);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::swap::consume_receipt_internal<T0, T1, T2, T3>(arg1, arg2, arg3, arg4);
    }

    public fun finalize<T0, T1, T2>(arg0: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::AdminCap, arg1: &mut 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg2: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::assert_current_version(arg2);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::finalize_wind_down<T0, T1, T2>(arg1);
        let v0 = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::seed_balance<T0, T1, T2>(arg1);
        let v1 = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::total_supply<T0, T1, T2>(arg1);
        let v2 = WindDownFinalizedEvent{
            vault_id                      : 0x2::object::id<0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>>(arg1),
            withdrawable_a                : 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::free_balance_a_val<T0, T1, T2>(arg1),
            withdrawable_b                : 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::free_balance_b_val<T0, T1, T2>(arg1),
            total_vault_coin_supply       : v1,
            seed_vault_coin_balance       : v0,
            circulating_vault_coin_supply : v1 - v0,
            sender                        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<WindDownFinalizedEvent>(v2);
    }

    public fun issue_reward_swap<T0, T1, T2, T3>(arg0: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::AdminCap, arg1: &mut 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg2: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault_acl::VaultAcl, arg3: &0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::acl::RouterAcl, arg4: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::assert_current_version(arg4);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::assert_unwinding<T0, T1, T2>(arg1);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::swap::issue_receipt_internal<T0, T1, T2, T3>(arg1, arg2, arg3, arg5)
    }

    public fun preview_withdraw<T0, T1, T2>(arg0: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg1: u64) : (u64, u64) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::preview_finalized_share<T0, T1, T2>(arg0, arg1)
    }

    public fun remove_all_liquidity<T0, T1, T2>(arg0: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::AdminCap, arg1: &mut 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::assert_current_version(arg5);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::assert_unwinding<T0, T1, T2>(arg1);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::check_pool_compatibility<T0, T1, T2>(arg1, arg2);
        assert!(0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::has_position<T0, T1, T2>(arg1), 0);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::info_liquidity(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::borrow_position_info<T0, T1>(arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::position_borrow<T0, T1, T2>(arg1))));
        let (v1, v2) = if (v0 > 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg3, arg2, 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::position_borrow_mut<T0, T1, T2>(arg1), v0, arg4)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v3 = v2;
        let v4 = v1;
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::add_free_balance_a<T0, T1, T2>(arg1, v4);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::add_free_balance_b<T0, T1, T2>(arg1, v3);
        let v5 = LiquidityRemovedEvent{
            vault_id          : 0x2::object::id<0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>>(arg1),
            liquidity_removed : v0,
            amount_a          : 0x2::balance::value<T0>(&v4),
            amount_b          : 0x2::balance::value<T1>(&v3),
            sender            : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<LiquidityRemovedEvent>(v5);
    }

    public fun set_reward_route<T0, T1, T2, T3>(arg0: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::AdminCap, arg1: &mut 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg2: vector<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>, arg3: bool, arg4: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::Version) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::assert_current_version(arg4);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::assert_unwinding<T0, T1, T2>(arg1);
        assert!(!0x1::vector::is_empty<0x360802cb106b004205cd67a706e314eaeadd8590d5f4d1cee46137566232a627::bag_value::Value>(&arg2), 3);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::set_swap_route<T0, T1, T2, T3>(arg1, arg2, arg3);
    }

    public entry fun withdraw<T0, T1, T2>(arg0: &mut 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: u64, arg4: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::assert_current_version(arg4);
        let (v0, v1, v2) = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::take_finalized_share<T0, T1, T2>(arg0, arg1);
        let v3 = v1;
        let v4 = v0;
        let v5 = 0x2::balance::value<T0>(&v4);
        let v6 = 0x2::balance::value<T1>(&v3);
        assert!(v5 >= arg2 && v6 >= arg3, 2);
        let v7 = WithdrawEvent{
            vault_id         : 0x2::object::id<0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>>(arg0),
            vault_coin_burnt : v2,
            withdraw_coin_a  : v5,
            withdraw_coin_b  : v6,
            sender           : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<WithdrawEvent>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg5), 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun withdrawable_balances<T0, T1, T2>(arg0: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>) : (u64, u64, u64, u64) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::assert_finalized<T0, T1, T2>(arg0);
        (0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::free_balance_a_val<T0, T1, T2>(arg0), 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::free_balance_b_val<T0, T1, T2>(arg0), 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::total_supply<T0, T1, T2>(arg0), 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::seed_balance<T0, T1, T2>(arg0))
    }

    // decompiled from Move bytecode v7
}

