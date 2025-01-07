module 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::rebalance {
    struct RebalanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        residual_coin_a: u64,
        residual_coin_b: u64,
        lower_tick: u32,
        upper_tick: u32,
        lower_trigger_price: u128,
        upper_trigger_price: u128,
        timestamp_ms: u64,
        last_rebalance_time: u64,
    }

    struct LpResidualEvent has copy, drop {
        vault_id: 0x2::object::ID,
        residual_coin_a: u64,
        residual_coin_b: u64,
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::RebalanceCap, arg4: &0x2::clock::Clock, arg5: &0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::assert_rebalance_cap<T0, T1, T2>(arg0, arg3, arg6);
        0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        let v0 = 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::lower_trigger_price<T0, T1, T2>(arg0);
        let v1 = 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::upper_trigger_price<T0, T1, T2>(arg0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) >= v0 && 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) <= v1 || v0 == 0 && v1 == 0, 0);
        0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::collect::fees<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6);
        let (v2, v3) = 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::utils::close_position<T0, T1, T2>(arg0, arg1, arg2, arg4);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7, v8, v9) = 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::utils::create_position<T0, T1, T2>(arg0, arg1, arg2, &mut v5, &mut v4, arg4, arg6);
        0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::update_ticks_info<T0, T1, T2>(arg0, v6, v7);
        0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::update_trigger_ticks_info<T0, T1, T2>(arg0, v8, v9);
        0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::add_free_balance_a<T0, T1, T2>(arg0, v5);
        0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::add_free_balance_b<T0, T1, T2>(arg0, v4);
        lp_residual_amount<T0, T1, T2>(arg0, arg1, arg2, arg4, true, 0, arg3, arg5, arg6);
        lp_residual_amount<T0, T1, T2>(arg0, arg1, arg2, arg4, false, 0, arg3, arg5, arg6);
        0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::set_rebalance_time<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg4));
        emit_event(0x2::object::id<0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::Vault<T0, T1, T2>>(arg0), 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::free_balance_a_val<T0, T1, T2>(arg0), 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::free_balance_b_val<T0, T1, T2>(arg0), v6, v7, v8, v9, 0x2::clock::timestamp_ms(arg4), 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::last_rebalance_time<T0, T1, T2>(arg0));
    }

    fun emit_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u32, arg4: u32, arg5: u128, arg6: u128, arg7: u64, arg8: u64) {
        let v0 = RebalanceEvent{
            vault_id            : arg0,
            residual_coin_a     : arg1,
            residual_coin_b     : arg2,
            lower_tick          : arg3,
            upper_tick          : arg4,
            lower_trigger_price : arg5,
            upper_trigger_price : arg6,
            timestamp_ms        : arg7,
            last_rebalance_time : arg8,
        };
        0x2::event::emit<RebalanceEvent>(v0);
    }

    public fun lp_residual_amount<T0, T1, T2>(arg0: &mut 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: &0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::RebalanceCap, arg7: &0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::version::assert_current_version(arg7);
        0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::assert_rebalance_cap<T0, T1, T2>(arg0, arg6, arg8);
        0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        if (arg4 && (0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::free_balance_a_val<T0, T1, T2>(arg0) > 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::free_threshold_a<T0, T1, T2>(arg0) || arg5 > 0)) {
            let (v1, v2) = if (arg5 == 0) {
                0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2>(arg0, arg1, 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::free_balance_a_val<T0, T1, T2>(arg0), true, 10)
            } else {
                (arg5, false)
            };
            let v3 = 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::get_free_balance_a<T0, T1, T2>(arg0);
            assert!(v1 <= 0x2::balance::value<T0>(&v3), 10);
            let (v4, v5) = 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::utils::swap<T0, T1>(arg2, arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v1), arg8), 0x2::coin::zero<T1>(arg8), true, true, v1, 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::utils::slippage_adjusted_sqrt_price(true, 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::slippage<T0, T1, T2>(arg0), v0), arg3, arg8);
            let v6 = v5;
            0x2::coin::destroy_zero<T0>(v4);
            let v7 = if (v2) {
                0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::free_balance_a_val<T0, T1, T2>(arg0)
            } else {
                0x2::coin::value<T1>(&v6)
            };
            let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::position_borrow_mut<T0, T1, T2>(arg0), v7, v2, arg3);
            let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v8);
            let v11 = 0x2::coin::into_balance<T1>(v6);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, 0x2::balance::split<T0>(&mut v3, v9), 0x2::balance::split<T1>(&mut v11, v10), v8);
            0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::add_free_balance_a<T0, T1, T2>(arg0, v3);
            0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::add_free_balance_b<T0, T1, T2>(arg0, v11);
            let v12 = LpResidualEvent{
                vault_id        : 0x2::object::id<0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::Vault<T0, T1, T2>>(arg0),
                residual_coin_a : 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::free_balance_a_val<T0, T1, T2>(arg0),
                residual_coin_b : 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::free_balance_b_val<T0, T1, T2>(arg0),
            };
            0x2::event::emit<LpResidualEvent>(v12);
        };
        if (!arg4 && (0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::free_balance_b_val<T0, T1, T2>(arg0) > 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::free_threshold_b<T0, T1, T2>(arg0) || arg5 > 0)) {
            let (v13, v14) = if (arg5 == 0) {
                0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2>(arg0, arg1, 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::free_balance_b_val<T0, T1, T2>(arg0), false, 10)
            } else {
                (arg5, false)
            };
            let v15 = 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::get_free_balance_b<T0, T1, T2>(arg0);
            assert!(v13 <= 0x2::balance::value<T1>(&v15), 11);
            let (v16, v17) = 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::utils::swap<T0, T1>(arg2, arg1, 0x2::coin::zero<T0>(arg8), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v15, v13), arg8), false, true, v13, 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::utils::slippage_adjusted_sqrt_price(false, 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::slippage<T0, T1, T2>(arg0), v0), arg3, arg8);
            let v18 = v16;
            0x2::coin::destroy_zero<T1>(v17);
            let v19 = if (v14) {
                0x2::coin::value<T0>(&v18)
            } else {
                0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::free_balance_b_val<T0, T1, T2>(arg0)
            };
            let v20 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::position_borrow_mut<T0, T1, T2>(arg0), v19, v14, arg3);
            let (v21, v22) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v20);
            let v23 = 0x2::coin::into_balance<T0>(v18);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, 0x2::balance::split<T0>(&mut v23, v21), 0x2::balance::split<T1>(&mut v15, v22), v20);
            0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::add_free_balance_b<T0, T1, T2>(arg0, v15);
            0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::add_free_balance_a<T0, T1, T2>(arg0, v23);
            let v24 = LpResidualEvent{
                vault_id        : 0x2::object::id<0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::Vault<T0, T1, T2>>(arg0),
                residual_coin_a : 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::free_balance_a_val<T0, T1, T2>(arg0),
                residual_coin_b : 0x28261ec69cb3f73ab180adc2627d7da6ac65dd0c82ada6dbc507fd0aadebc173::vault::free_balance_b_val<T0, T1, T2>(arg0),
            };
            0x2::event::emit<LpResidualEvent>(v24);
        };
    }

    // decompiled from Move bytecode v6
}

