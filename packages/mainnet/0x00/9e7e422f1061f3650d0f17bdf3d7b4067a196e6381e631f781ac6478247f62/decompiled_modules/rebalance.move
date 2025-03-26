module 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::rebalance {
    struct RebalanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        rebalance_cap_id: 0x2::object::ID,
        lower_tick: u32,
        upper_tick: u32,
        lower_trigger_price: u128,
        upper_trigger_price: u128,
        current_sqrt_price: u128,
        timestamp_ms: u64,
        last_rebalance_time: u64,
        lp_residual_event_a: 0x1::option::Option<LpResidualEvent>,
        lp_residual_event_b: 0x1::option::Option<LpResidualEvent>,
    }

    struct LpResidualEvent has copy, drop {
        vault_id: 0x2::object::ID,
        rebalance_cap_id: 0x2::object::ID,
        lp_coin_a: u64,
        lp_coin_b: u64,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        is_a: bool,
        swap_amt: u64,
        residual_coin_a: u64,
        residual_coin_b: u64,
        timestamp_ms: u64,
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::RebalanceCap, arg4: &0x2::clock::Clock, arg5: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::assert_rebalance_cap<T0, T1, T2>(arg0, arg3, arg6);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::lower_trigger_price<T0, T1, T2>(arg0);
        let v2 = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::upper_trigger_price<T0, T1, T2>(arg0);
        let v3 = if (v0 <= v1) {
            true
        } else if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) >= v2) {
            true
        } else {
            v1 == 0 && v2 == 0
        };
        assert!(v3, 0);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::collect::fees<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6);
        let (v4, v5) = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::utils::close_position<T0, T1, T2>(arg0, arg1, arg2, arg4);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9, v10, v11) = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::utils::create_position<T0, T1, T2>(arg0, arg1, arg2, &mut v7, &mut v6, arg4, arg6);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::update_ticks_info<T0, T1, T2>(arg0, v8, v9);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::update_trigger_ticks_info<T0, T1, T2>(arg0, v10, v11);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::add_free_balance_a<T0, T1, T2>(arg0, v7);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::add_free_balance_b<T0, T1, T2>(arg0, v6);
        let (v12, _) = lp_residual_amount<T0, T1, T2>(arg0, arg1, arg2, arg4, true, 0, arg3, arg5, arg6);
        let (_, v15) = lp_residual_amount<T0, T1, T2>(arg0, arg1, arg2, arg4, false, 0, arg3, arg5, arg6);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::set_rebalance_time<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg4));
        emit_event(0x2::object::id<0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>>(arg0), 0x2::object::id<0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::RebalanceCap>(arg3), v0, v8, v9, v10, v11, 0x2::clock::timestamp_ms(arg4), 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::last_rebalance_time<T0, T1, T2>(arg0), v12, v15);
    }

    fun emit_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u128, arg3: u32, arg4: u32, arg5: u128, arg6: u128, arg7: u64, arg8: u64, arg9: 0x1::option::Option<LpResidualEvent>, arg10: 0x1::option::Option<LpResidualEvent>) {
        let v0 = RebalanceEvent{
            vault_id            : arg0,
            rebalance_cap_id    : arg1,
            lower_tick          : arg3,
            upper_tick          : arg4,
            lower_trigger_price : arg5,
            upper_trigger_price : arg6,
            current_sqrt_price  : arg2,
            timestamp_ms        : arg7,
            last_rebalance_time : arg8,
            lp_residual_event_a : arg9,
            lp_residual_event_b : arg10,
        };
        0x2::event::emit<RebalanceEvent>(v0);
    }

    public fun lp_residual_amount<T0, T1, T2>(arg0: &mut 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::RebalanceCap, arg7: &0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::Version, arg8: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<LpResidualEvent>, 0x1::option::Option<LpResidualEvent>) {
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::version::assert_current_version(arg7);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::assert_rebalance_cap<T0, T1, T2>(arg0, arg6, arg8);
        0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (v1, v2) = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::slippage<T0, T1, T2>(arg0);
        let v3 = 0x1::option::none<LpResidualEvent>();
        let v4 = 0x1::option::none<LpResidualEvent>();
        if (arg4 && (0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::free_balance_a_val<T0, T1, T2>(arg0) > 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::free_threshold_a<T0, T1, T2>(arg0) || arg5 > 0)) {
            let v5 = if (arg5 == 0) {
                let (v6, _) = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2>(arg0, arg1, 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::free_balance_a_val<T0, T1, T2>(arg0), true, 10);
                v6
            } else {
                arg5
            };
            let v8 = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::get_free_balance_a<T0, T1, T2>(arg0);
            assert!(v5 <= 0x2::balance::value<T0>(&v8), 10);
            let (v9, v10) = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::utils::swap<T0, T1>(arg2, arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v5), arg8), 0x2::coin::zero<T1>(arg8), true, true, v5, 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::utils::slippage_adjusted_sqrt_price(true, v1, v2, v0), arg3, arg8);
            let v11 = v10;
            0x2::coin::destroy_zero<T0>(v9);
            let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
            let (v13, v14) = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::get_position_tick_range<T0, T1, T2>(arg0);
            let (v15, v16, v17) = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::utils::check_is_fix_coin_a(v13, v14, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), v12, 0x2::balance::value<T0>(&v8), 0x2::coin::value<T1>(&v11));
            let v18 = if (v15) {
                v16
            } else {
                v17
            };
            let v19 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::position_borrow_mut<T0, T1, T2>(arg0), v18, v15, arg3);
            let (v20, v21) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v19);
            let v22 = 0x2::coin::into_balance<T1>(v11);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, 0x2::balance::split<T0>(&mut v8, v20), 0x2::balance::split<T1>(&mut v22, v21), v19);
            0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::add_free_balance_a<T0, T1, T2>(arg0, v8);
            0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::add_free_balance_b<T0, T1, T2>(arg0, v22);
            let v23 = LpResidualEvent{
                vault_id          : 0x2::object::id<0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>>(arg0),
                rebalance_cap_id  : 0x2::object::id<0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::RebalanceCap>(arg6),
                lp_coin_a         : v20,
                lp_coin_b         : v21,
                before_sqrt_price : v0,
                after_sqrt_price  : v12,
                is_a              : arg4,
                swap_amt          : v5,
                residual_coin_a   : 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::free_balance_a_val<T0, T1, T2>(arg0),
                residual_coin_b   : 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::free_balance_b_val<T0, T1, T2>(arg0),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg3),
            };
            0x1::option::fill<LpResidualEvent>(&mut v3, v23);
            0x2::event::emit<LpResidualEvent>(v23);
        };
        if (!arg4 && (0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::free_balance_b_val<T0, T1, T2>(arg0) > 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::free_threshold_b<T0, T1, T2>(arg0) || arg5 > 0)) {
            let v24 = if (arg5 == 0) {
                let (v25, _) = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2>(arg0, arg1, 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::free_balance_b_val<T0, T1, T2>(arg0), false, 10);
                v25
            } else {
                arg5
            };
            let v27 = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::get_free_balance_b<T0, T1, T2>(arg0);
            assert!(v24 <= 0x2::balance::value<T1>(&v27), 11);
            let (v28, v29) = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::utils::swap<T0, T1>(arg2, arg1, 0x2::coin::zero<T0>(arg8), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v27, v24), arg8), false, true, v24, 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::utils::slippage_adjusted_sqrt_price(false, v1, v2, v0), arg3, arg8);
            let v30 = v28;
            0x2::coin::destroy_zero<T1>(v29);
            let v31 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
            let (v32, v33) = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::get_position_tick_range<T0, T1, T2>(arg0);
            let (v34, v35, v36) = 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::utils::check_is_fix_coin_a(v32, v33, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), v31, 0x2::coin::value<T0>(&v30), 0x2::balance::value<T1>(&v27));
            let v37 = if (v34) {
                v35
            } else {
                v36
            };
            let v38 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::position_borrow_mut<T0, T1, T2>(arg0), v37, v34, arg3);
            let (v39, v40) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v38);
            let v41 = 0x2::coin::into_balance<T0>(v30);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, 0x2::balance::split<T0>(&mut v41, v39), 0x2::balance::split<T1>(&mut v27, v40), v38);
            0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::add_free_balance_b<T0, T1, T2>(arg0, v27);
            0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::add_free_balance_a<T0, T1, T2>(arg0, v41);
            let v42 = LpResidualEvent{
                vault_id          : 0x2::object::id<0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::Vault<T0, T1, T2>>(arg0),
                rebalance_cap_id  : 0x2::object::id<0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::RebalanceCap>(arg6),
                lp_coin_a         : v39,
                lp_coin_b         : v40,
                before_sqrt_price : v0,
                after_sqrt_price  : v31,
                is_a              : arg4,
                swap_amt          : v24,
                residual_coin_a   : 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::free_balance_a_val<T0, T1, T2>(arg0),
                residual_coin_b   : 0x27a995eb806f164ccb9cb4f5d4e83b71372b9db7e55bccd59dfe4666bdeae065::vault::free_balance_b_val<T0, T1, T2>(arg0),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg3),
            };
            0x1::option::fill<LpResidualEvent>(&mut v4, v42);
            0x2::event::emit<LpResidualEvent>(v42);
        };
        (v3, v4)
    }

    // decompiled from Move bytecode v6
}

