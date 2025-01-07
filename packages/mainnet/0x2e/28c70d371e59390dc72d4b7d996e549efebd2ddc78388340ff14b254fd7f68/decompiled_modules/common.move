module 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::common {
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
        vault_type: 0x1::ascii::String,
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

    public(friend) fun emit_rebalance_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u128, arg3: u32, arg4: u32, arg5: u128, arg6: u128, arg7: u64, arg8: u64, arg9: 0x1::option::Option<LpResidualEvent>, arg10: 0x1::option::Option<LpResidualEvent>, arg11: 0x1::ascii::String) {
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
            vault_type          : arg11,
        };
        0x2::event::emit<RebalanceEvent>(v0);
    }

    public fun lp_residual_amount<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64, arg5: &0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::RebalanceCap, arg6: &0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::version::Version, arg7: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg8: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<LpResidualEvent>, 0x1::option::Option<LpResidualEvent>) {
        0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::version::assert_supported_version(arg6);
        0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::assert_rebalance_cap<T0, T1, T2, T3>(arg0, arg5, arg8);
        0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        let v0 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1);
        let (v1, v2) = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::get_slippage<T0, T1, T2, T3>(arg0);
        let v3 = 0x1::option::none<LpResidualEvent>();
        let v4 = 0x1::option::none<LpResidualEvent>();
        if (arg3 && (0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::free_balance_a_val<T0, T1, T2, T3>(arg0) > 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::free_threshold_a<T0, T1, T2, T3>(arg0) || arg4 > 0)) {
            let v5 = if (arg4 == 0) {
                let (v6, _) = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2, T3>(arg0, arg1, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::free_balance_a_val<T0, T1, T2, T3>(arg0), true, 10);
                v6
            } else {
                arg4
            };
            let v8 = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::get_free_balance_a<T0, T1, T2, T3>(arg0);
            assert!(v5 <= 0x2::balance::value<T0>(&v8), 10);
            let (v9, v10) = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::utils::swap<T0, T1>(arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v5), arg8), 0x2::coin::zero<T1>(arg8), true, true, v5, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::utils::slippage_adjusted_sqrt_price(true, v1, v2, v0), arg2, arg7, arg8);
            let v11 = v10;
            0x2::coin::destroy_zero<T0>(v9);
            let v12 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1);
            let (v13, v14) = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::get_position_tick_range<T0, T1, T2, T3>(arg0);
            let (_, v16, v17) = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::utils::check_is_fix_coin_a(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v13), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v14), v12, 0x2::balance::value<T0>(&v8), 0x2::coin::value<T1>(&v11));
            let (v18, v19) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::add_liquidity<T0, T1>(arg1, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v16), arg8), 0x2::coin::split<T1>(&mut v11, v17, arg8), 0, 0, arg2, arg7, arg8);
            let v20 = v19;
            let v21 = v18;
            0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T0>(v21));
            0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(v20));
            0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, v8);
            0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(v11));
            let v22 = LpResidualEvent{
                vault_id          : 0x2::object::id<0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::Vault<T0, T1, T2, T3>>(arg0),
                rebalance_cap_id  : 0x2::object::id<0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::RebalanceCap>(arg5),
                lp_coin_a         : v16 - 0x2::coin::value<T0>(&v21),
                lp_coin_b         : v17 - 0x2::coin::value<T1>(&v20),
                before_sqrt_price : v0,
                after_sqrt_price  : v12,
                is_a              : arg3,
                swap_amt          : v5,
                residual_coin_a   : 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::free_balance_a_val<T0, T1, T2, T3>(arg0),
                residual_coin_b   : 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::free_balance_b_val<T0, T1, T2, T3>(arg0),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg2),
            };
            0x1::option::fill<LpResidualEvent>(&mut v3, v22);
            0x2::event::emit<LpResidualEvent>(v22);
        };
        if (!arg3 && (0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::free_balance_b_val<T0, T1, T2, T3>(arg0) > 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::free_threshold_b<T0, T1, T2, T3>(arg0) || arg4 > 0)) {
            let v23 = if (arg4 == 0) {
                let (v24, _) = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2, T3>(arg0, arg1, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::free_balance_b_val<T0, T1, T2, T3>(arg0), false, 10);
                v24
            } else {
                arg4
            };
            let v26 = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::get_free_balance_b<T0, T1, T2, T3>(arg0);
            assert!(v23 <= 0x2::balance::value<T1>(&v26), 11);
            let (v27, v28) = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::utils::swap<T0, T1>(arg1, 0x2::coin::zero<T0>(arg8), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v26, v23), arg8), false, true, v23, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::utils::slippage_adjusted_sqrt_price(false, v1, v2, v0), arg2, arg7, arg8);
            let v29 = v27;
            0x2::coin::destroy_zero<T1>(v28);
            let v30 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::sqrt_price<T0, T1>(arg1);
            let (v31, v32) = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::get_position_tick_range<T0, T1, T2, T3>(arg0);
            let (_, v34, v35) = 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::utils::check_is_fix_coin_a(0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v31), 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::tick_math::get_sqrt_price_at_tick(v32), v30, 0x2::coin::value<T0>(&v29), 0x2::balance::value<T1>(&v26));
            let (v36, v37) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::liquidity::add_liquidity<T0, T1>(arg1, 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), 0x2::coin::split<T0>(&mut v29, v34, arg8), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v26, v35), arg8), 0, 0, arg2, arg7, arg8);
            let v38 = v37;
            let v39 = v36;
            0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(v38));
            0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T0>(v39));
            0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, v26);
            0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T0>(v29));
            let v40 = LpResidualEvent{
                vault_id          : 0x2::object::id<0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::Vault<T0, T1, T2, T3>>(arg0),
                rebalance_cap_id  : 0x2::object::id<0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::RebalanceCap>(arg5),
                lp_coin_a         : v34 - 0x2::coin::value<T0>(&v39),
                lp_coin_b         : v35 - 0x2::coin::value<T1>(&v38),
                before_sqrt_price : v0,
                after_sqrt_price  : v30,
                is_a              : arg3,
                swap_amt          : v23,
                residual_coin_a   : 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::free_balance_a_val<T0, T1, T2, T3>(arg0),
                residual_coin_b   : 0x2e28c70d371e59390dc72d4b7d996e549efebd2ddc78388340ff14b254fd7f68::vault::free_balance_b_val<T0, T1, T2, T3>(arg0),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg2),
            };
            0x1::option::fill<LpResidualEvent>(&mut v4, v40);
            0x2::event::emit<LpResidualEvent>(v40);
        };
        (v3, v4)
    }

    // decompiled from Move bytecode v6
}

