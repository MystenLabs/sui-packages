module 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_live {
    struct CetusPositionOpenedEvent has copy, drop, store {
        sender: address,
        configured_pool_id: address,
        actual_pool_id: address,
        position_id: address,
        coin_a_in: u64,
        coin_b_in: u64,
        change_a: u64,
        change_b: u64,
        liquidity: u128,
        tick_lower: u32,
        tick_upper: u32,
        fix_amount_a: bool,
    }

    struct CetusPositionClosedEvent has copy, drop, store {
        sender: address,
        configured_pool_id: address,
        actual_pool_id: address,
        position_id: address,
        coin_a_out: u64,
        coin_b_out: u64,
        liquidity_removed: u128,
    }

    struct CetusPositionAdjustedEvent has copy, drop, store {
        sender: address,
        configured_pool_id: address,
        actual_pool_id: address,
        position_id: address,
        action_code: u64,
        amount_a_before: u64,
        amount_b_before: u64,
        amount_a_after: u64,
        amount_b_after: u64,
        coin_a_flow: u64,
        coin_b_flow: u64,
    }

    public fun add_liquidity_to_stored_position_from_vault<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::assert_operator_if_configured<T0>(arg0, arg9);
        assert!(arg6 > 0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_zero_amount());
        assert_pool_matches_config<T1, T2>(arg1, arg3);
        let (v0, v1, v2) = stored_position_snapshot<T0, T1, T2>(arg0, arg3);
        let (v3, v4) = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_amm::add_liquidity_fix_coin_and_repay<T1, T2>(arg2, arg3, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::borrow_stored_cetus_position_mut<T0>(arg0), arg4, arg5, arg6, arg7, arg8, arg9);
        let v5 = v4;
        let v6 = v3;
        let (v7, v8, v9) = stored_position_snapshot<T0, T1, T2>(arg0, arg3);
        assert!(v0 == v7, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_object_mismatch());
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::record_cetus_live_add<T0>(arg0, arg1, v7, v8, v9, 0x2::clock::timestamp_ms(arg8));
        let v10 = CetusPositionAdjustedEvent{
            sender             : 0x2::tx_context::sender(arg9),
            configured_pool_id : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::cetus_pool_id(arg1),
            actual_pool_id     : pool_address<T1, T2>(arg3),
            position_id        : v7,
            action_code        : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_add(),
            amount_a_before    : v1,
            amount_b_before    : v2,
            amount_a_after     : v8,
            amount_b_after     : v9,
            coin_a_flow        : 0x2::coin::value<T1>(&v6),
            coin_b_flow        : 0x2::coin::value<T2>(&v5),
        };
        0x2::event::emit<CetusPositionAdjustedEvent>(v10);
        (v6, v5)
    }

    fun assert_expected_lp_action<T0>(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: u64) {
        let (v0, _) = expected_lp_plan<T0>(arg0, arg1, arg2);
        assert!(v0 == arg3, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_invalid_plan());
    }

    public fun assert_planned_add_action<T0>(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) {
        assert_expected_lp_action<T0>(arg0, arg1, arg2, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_add());
    }

    public fun assert_planned_close_action<T0>(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) {
        assert_expected_lp_action<T0>(arg0, arg1, arg2, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_close());
    }

    public fun assert_planned_open_action<T0>(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) {
        assert_expected_lp_action<T0>(arg0, arg1, arg2, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_open());
    }

    public fun assert_planned_remove_action<T0>(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) {
        assert_expected_lp_action<T0>(arg0, arg1, arg2, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_remove());
    }

    fun assert_pool_matches_config<T0, T1>(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        assert!(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_amm::is_available(arg0), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_adapter_not_implemented());
        assert!(0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::cetus_pool_id(arg0) == pool_address<T0, T1>(arg1), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_object_mismatch());
    }

    public fun close_position_and_withdraw<T0, T1>(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, _) = close_position_and_withdraw_details<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        (v0, v1)
    }

    fun close_position_and_withdraw_details<T0, T1>(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, address) {
        assert_pool_matches_config<T0, T1>(arg0, arg2);
        let v0 = position_address(&arg3);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg3);
        assert!(v1 > 0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_zero_amount());
        let (v2, v3) = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_amm::remove_liquidity_to_coins<T0, T1>(arg1, arg2, &mut arg3, v1, arg4, arg5);
        let v4 = v3;
        let v5 = v2;
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg1, arg2, arg3);
        let v6 = CetusPositionClosedEvent{
            sender             : 0x2::tx_context::sender(arg5),
            configured_pool_id : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::cetus_pool_id(arg0),
            actual_pool_id     : pool_address<T0, T1>(arg2),
            position_id        : v0,
            coin_a_out         : 0x2::coin::value<T0>(&v5),
            coin_b_out         : 0x2::coin::value<T1>(&v4),
            liquidity_removed  : v1,
        };
        0x2::event::emit<CetusPositionClosedEvent>(v6);
        (v5, v4, v0)
    }

    public fun close_position_and_withdraw_entry<T0, T1>(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = close_position_and_withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg5));
    }

    public fun close_stored_position_from_vault<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::assert_operator_if_configured<T0>(arg0, arg5);
        let (v0, v1, v2) = close_position_and_withdraw_details<T1, T2>(arg1, arg2, arg3, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::take_cetus_position<T0>(arg0), arg4, arg5);
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::record_cetus_live_close<T0>(arg0, arg1, v2, 0x2::clock::timestamp_ms(arg4));
        (v0, v1)
    }

    public fun close_stored_position_from_vault_entry<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = close_stored_position_from_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, 0x2::tx_context::sender(arg5));
    }

    public fun cycle_live<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, 0x1::option::Option<0x2::coin::Coin<T0>>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, u64, u64, u64) {
        if (should_close_live_position<T0>(arg0, arg1, arg2)) {
            assert_pool_matches_config<T1, T2>(arg2, arg4);
            let (_, v1, v2) = stored_position_snapshot<T0, T1, T2>(arg0, arg4);
            let (v3, v4) = close_stored_position_from_vault<T0, T1, T2>(arg0, arg2, arg3, arg4, arg6, arg7);
            let (v5, v6) = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::cycle<T0>(arg0, arg1, arg2, arg5, arg6, arg7);
            return (v5, v6, v3, v4, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_close(), v1, v2)
        };
        let (v7, v8, v9, v10) = rebalance_live<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, arg6, arg7);
        let (v11, v12, v13) = if (should_close_live_position<T0>(arg0, arg1, arg2)) {
            let (v14, v15) = close_stored_position_from_vault<T0, T1, T2>(arg0, arg2, arg3, arg4, arg6, arg7);
            (v14, v15, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_close())
        } else {
            (0x2::coin::zero<T1>(arg7), 0x2::coin::zero<T2>(arg7), 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_hold())
        };
        (v7, v8, v11, v12, v13, v9, v10)
    }

    public fun cycle_live_entry<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (_, v1, v2, v3, _, _, _) = cycle_live<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v7 = v3;
        let v8 = v2;
        let v9 = v1;
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v9)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(v9), 0x2::tx_context::sender(arg7));
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(v9);
        };
        if (0x2::coin::value<T1>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v8, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T1>(v8);
        };
        if (0x2::coin::value<T2>(&v7) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T2>(v7);
        };
    }

    public fun cycle_managed_live_lp_entry<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<T2>, arg7: u32, arg8: u32, arg9: u64, arg10: bool, arg11: u128, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg14);
        if (should_close_live_position<T0>(arg0, arg1, arg2) && 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::has_stored_cetus_position<T0>(arg0)) {
            let (v1, v2) = close_stored_position_from_vault<T0, T1, T2>(arg0, arg2, arg3, arg4, arg13, arg14);
            let v3 = v2;
            let v4 = v1;
            let (_, v6) = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::cycle<T0>(arg0, arg1, arg2, arg12, arg13, arg14);
            let v7 = v6;
            if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v7)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(v7), v0);
            } else {
                0x1::option::destroy_none<0x2::coin::Coin<T0>>(v7);
            };
            if (0x2::coin::value<T1>(&arg5) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, v0);
            } else {
                0x2::coin::destroy_zero<T1>(arg5);
            };
            if (0x2::coin::value<T2>(&arg6) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg6, v0);
            } else {
                0x2::coin::destroy_zero<T2>(arg6);
            };
            if (0x2::coin::value<T1>(&v4) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, v0);
            } else {
                0x2::coin::destroy_zero<T1>(v4);
            };
            if (0x2::coin::value<T2>(&v3) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v3, v0);
            } else {
                0x2::coin::destroy_zero<T2>(v3);
            };
            return
        };
        let (_, v9) = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::cycle<T0>(arg0, arg1, arg2, arg12, arg13, arg14);
        let v10 = v9;
        let (v11, _) = expected_lp_plan<T0>(arg0, arg1, arg2);
        if (v11 == 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_open()) {
            let (v13, v14) = open_position_into_vault<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg13, arg14);
            let v15 = v14;
            let v16 = v13;
            if (0x2::coin::value<T1>(&v16) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v16, v0);
            } else {
                0x2::coin::destroy_zero<T1>(v16);
            };
            if (0x2::coin::value<T2>(&v15) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v15, v0);
            } else {
                0x2::coin::destroy_zero<T2>(v15);
            };
        } else if (v11 == 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_add()) {
            let (v17, v18) = add_liquidity_to_stored_position_from_vault<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg9, arg10, arg13, arg14);
            let v19 = v18;
            let v20 = v17;
            if (0x2::coin::value<T1>(&v20) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v20, v0);
            } else {
                0x2::coin::destroy_zero<T1>(v20);
            };
            if (0x2::coin::value<T2>(&v19) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v19, v0);
            } else {
                0x2::coin::destroy_zero<T2>(v19);
            };
        } else if (v11 == 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_remove()) {
            let (v21, v22) = remove_liquidity_from_stored_position_from_vault<T0, T1, T2>(arg0, arg2, arg3, arg4, arg11, arg13, arg14);
            let v23 = v22;
            let v24 = v21;
            if (0x2::coin::value<T1>(&arg5) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, v0);
            } else {
                0x2::coin::destroy_zero<T1>(arg5);
            };
            if (0x2::coin::value<T2>(&arg6) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg6, v0);
            } else {
                0x2::coin::destroy_zero<T2>(arg6);
            };
            if (0x2::coin::value<T1>(&v24) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v24, v0);
            } else {
                0x2::coin::destroy_zero<T1>(v24);
            };
            if (0x2::coin::value<T2>(&v23) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v23, v0);
            } else {
                0x2::coin::destroy_zero<T2>(v23);
            };
        } else if (v11 == 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_close() && 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::has_stored_cetus_position<T0>(arg0)) {
            let (v25, v26) = close_stored_position_from_vault<T0, T1, T2>(arg0, arg2, arg3, arg4, arg13, arg14);
            let v27 = v26;
            let v28 = v25;
            if (0x2::coin::value<T1>(&arg5) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, v0);
            } else {
                0x2::coin::destroy_zero<T1>(arg5);
            };
            if (0x2::coin::value<T2>(&arg6) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg6, v0);
            } else {
                0x2::coin::destroy_zero<T2>(arg6);
            };
            if (0x2::coin::value<T1>(&v28) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v28, v0);
            } else {
                0x2::coin::destroy_zero<T1>(v28);
            };
            if (0x2::coin::value<T2>(&v27) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v27, v0);
            } else {
                0x2::coin::destroy_zero<T2>(v27);
            };
        } else {
            if (0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::has_stored_cetus_position<T0>(arg0)) {
                assert_pool_matches_config<T1, T2>(arg2, arg4);
                let (v29, v30, v31) = stored_position_snapshot<T0, T1, T2>(arg0, arg4);
                0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::record_cetus_live_snapshot<T0>(arg0, arg2, v29, v30, v31, 0x2::clock::timestamp_ms(arg13));
            };
            if (0x2::coin::value<T1>(&arg5) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, v0);
            } else {
                0x2::coin::destroy_zero<T1>(arg5);
            };
            if (0x2::coin::value<T2>(&arg6) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(arg6, v0);
            } else {
                0x2::coin::destroy_zero<T2>(arg6);
            };
        };
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v10)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(v10), v0);
        } else {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(v10);
        };
    }

    public fun execute_planned_add_to_vault<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<T2>, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert_expected_lp_action<T0>(arg0, arg1, arg2, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_add());
        add_liquidity_to_stored_position_from_vault<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun execute_planned_add_to_vault_entry<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<T2>, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = execute_planned_add_to_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, 0x2::tx_context::sender(arg10));
    }

    public fun execute_planned_close_from_vault<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert_expected_lp_action<T0>(arg0, arg1, arg2, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_close());
        close_stored_position_from_vault<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6)
    }

    public fun execute_planned_close_from_vault_entry<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = execute_planned_close_from_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, 0x2::tx_context::sender(arg6));
    }

    public fun execute_planned_open_into_vault<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<T2>, arg7: u32, arg8: u32, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert_expected_lp_action<T0>(arg0, arg1, arg2, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_open());
        open_position_into_vault<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun execute_planned_open_into_vault_entry<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<T2>, arg7: u32, arg8: u32, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = execute_planned_open_into_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg12));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, 0x2::tx_context::sender(arg12));
    }

    public fun execute_planned_remove_from_vault<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert_expected_lp_action<T0>(arg0, arg1, arg2, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_remove());
        remove_liquidity_from_stored_position_from_vault<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun execute_planned_remove_from_vault_entry<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = execute_planned_remove_from_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, 0x2::tx_context::sender(arg7));
    }

    fun expected_lp_plan<T0>(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) : (u64, u64) {
        let (v0, v1, _, _, _, _) = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::strategy_plan_lp_for_testing<T0>(arg0, arg1, arg2);
        (v0, v1)
    }

    public fun open_position_into_vault<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: u32, arg7: u32, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::assert_operator_if_configured<T0>(arg0, arg11);
        let (v0, v1, v2, v3, v4, v5) = open_position_with_liquidity_details<T1, T2>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::store_cetus_position<T0>(arg0, v0);
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::record_cetus_live_open<T0>(arg0, arg1, v3, v4, v5, 0x2::clock::timestamp_ms(arg10));
        (v1, v2)
    }

    public fun open_position_into_vault_entry<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: 0x2::coin::Coin<T1>, arg5: 0x2::coin::Coin<T2>, arg6: u32, arg7: u32, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = open_position_into_vault<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v1, 0x2::tx_context::sender(arg11));
    }

    public fun open_position_with_liquidity<T0, T1>(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2, _, _, _) = open_position_with_liquidity_details<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        (v0, v1, v2)
    }

    fun open_position_with_liquidity_details<T0, T1>(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, address, u64, u64) {
        assert!(arg7 > 0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_zero_amount());
        assert_pool_matches_config<T0, T1>(arg0, arg2);
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0x2::coin::value<T1>(&arg4);
        let v2 = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_amm::open_position<T0, T1>(arg1, arg2, arg5, arg6, arg10);
        let (v3, v4) = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_amm::add_liquidity_fix_coin_and_repay<T0, T1>(arg1, arg2, &mut v2, arg3, arg4, arg7, arg8, arg9, arg10);
        let v5 = v4;
        let v6 = v3;
        let v7 = position_address(&v2);
        let v8 = 0x2::coin::value<T0>(&v6);
        let v9 = 0x2::coin::value<T1>(&v5);
        let v10 = CetusPositionOpenedEvent{
            sender             : 0x2::tx_context::sender(arg10),
            configured_pool_id : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::cetus_pool_id(arg0),
            actual_pool_id     : pool_address<T0, T1>(arg2),
            position_id        : v7,
            coin_a_in          : v0,
            coin_b_in          : v1,
            change_a           : v8,
            change_b           : v9,
            liquidity          : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v2),
            tick_lower         : arg5,
            tick_upper         : arg6,
            fix_amount_a       : arg8,
        };
        0x2::event::emit<CetusPositionOpenedEvent>(v10);
        (v2, v6, v5, v7, v0 - v8, v1 - v9)
    }

    public fun open_position_with_liquidity_entry<T0, T1>(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = open_position_with_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg10));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg10));
    }

    fun pool_address<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : address {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg0);
        0x2::object::id_to_address(&v0)
    }

    fun position_address(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : address {
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0);
        0x2::object::id_to_address(&v0)
    }

    public fun rebalance_live<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (u64, 0x1::option::Option<0x2::coin::Coin<T0>>, u64, u64) {
        let (v0, v1) = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::cycle<T0>(arg0, arg1, arg2, arg4, arg5, arg6);
        assert_pool_matches_config<T1, T2>(arg2, arg3);
        let (v2, v3) = if (0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::has_stored_cetus_position<T0>(arg0)) {
            let (v4, v5, v6) = stored_position_snapshot<T0, T1, T2>(arg0, arg3);
            0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::record_cetus_live_snapshot<T0>(arg0, arg2, v4, v5, v6, 0x2::clock::timestamp_ms(arg5));
            (v5, v6)
        } else {
            (0, 0)
        };
        (v0, v1, v2, v3)
    }

    public fun remove_liquidity_from_stored_position_from_vault<T0, T1, T2>(arg0: &mut 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::assert_operator_if_configured<T0>(arg0, arg6);
        assert!(arg4 > 0, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_zero_amount());
        assert_pool_matches_config<T1, T2>(arg1, arg3);
        let (v0, v1, v2) = stored_position_snapshot<T0, T1, T2>(arg0, arg3);
        let (v3, v4) = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_amm::remove_liquidity_to_coins<T1, T2>(arg2, arg3, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::borrow_stored_cetus_position_mut<T0>(arg0), arg4, arg5, arg6);
        let v5 = v4;
        let v6 = v3;
        let (v7, v8, v9) = stored_position_snapshot<T0, T1, T2>(arg0, arg3);
        assert!(v0 == v7, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_object_mismatch());
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::record_cetus_live_remove<T0>(arg0, arg1, v7, v8, v9, 0x2::clock::timestamp_ms(arg5));
        let v10 = CetusPositionAdjustedEvent{
            sender             : 0x2::tx_context::sender(arg6),
            configured_pool_id : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::cetus_pool_id(arg1),
            actual_pool_id     : pool_address<T1, T2>(arg3),
            position_id        : v7,
            action_code        : 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::types::lp_action_remove(),
            amount_a_before    : v1,
            amount_b_before    : v2,
            amount_a_after     : v8,
            amount_b_after     : v9,
            coin_a_flow        : 0x2::coin::value<T1>(&v6),
            coin_b_flow        : 0x2::coin::value<T2>(&v5),
        };
        0x2::event::emit<CetusPositionAdjustedEvent>(v10);
        (v6, v5)
    }

    fun should_close_live_position<T0>(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::queue::WithdrawalQueue, arg2: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config::Config) : bool {
        0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::should_close_live_cetus_from_strategy<T0>(arg0, arg1, arg2)
    }

    fun stored_position_snapshot<T0, T1, T2>(arg0: &0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::Vault<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>) : (address, u64, u64) {
        let (v0, v1) = 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::cetus_amm::get_position_amounts<T1, T2>(arg1, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::borrow_stored_cetus_position<T0>(arg0));
        (0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::entrypoints::stored_cetus_position_id<T0>(arg0), v0, v1)
    }

    // decompiled from Move bytecode v6
}

