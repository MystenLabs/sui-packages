module 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::rebalance {
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
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::RebalanceCap, arg4: &0x2::clock::Clock, arg5: &0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::assert_rebalance_cap<T0, T1, T2>(arg0, arg3, arg6);
        0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let v1 = 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::lower_trigger_price<T0, T1, T2>(arg0);
        let v2 = 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::upper_trigger_price<T0, T1, T2>(arg0);
        assert!(v0 <= v1 || 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) >= v2 || v1 == 0 && v2 == 0, 0);
        0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::collect::fees<T0, T1, T2>(arg0, arg1, arg2, arg5, arg6);
        let (v3, v4) = 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::utils::close_position<T0, T1, T2>(arg0, arg1, arg2, arg4);
        let v5 = v4;
        let v6 = v3;
        let (v7, v8, v9, v10) = 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::utils::create_position<T0, T1, T2>(arg0, arg1, arg2, &mut v6, &mut v5, arg4, arg6);
        0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::update_ticks_info<T0, T1, T2>(arg0, v7, v8);
        0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::update_trigger_ticks_info<T0, T1, T2>(arg0, v9, v10);
        0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::add_free_balance_a<T0, T1, T2>(arg0, v6);
        0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::add_free_balance_b<T0, T1, T2>(arg0, v5);
        lp_residual_amount<T0, T1, T2>(arg0, arg1, arg2, arg4, true, 0, arg3, arg5, arg6);
        lp_residual_amount<T0, T1, T2>(arg0, arg1, arg2, arg4, false, 0, arg3, arg5, arg6);
        0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::set_rebalance_time<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg4));
        emit_event(0x2::object::id<0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::Vault<T0, T1, T2>>(arg0), 0x2::object::id<0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::RebalanceCap>(arg3), v0, v7, v8, v9, v10, 0x2::clock::timestamp_ms(arg4), 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::last_rebalance_time<T0, T1, T2>(arg0));
    }

    fun emit_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u128, arg3: u32, arg4: u32, arg5: u128, arg6: u128, arg7: u64, arg8: u64) {
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
        };
        0x2::event::emit<RebalanceEvent>(v0);
    }

    public fun lp_residual_amount<T0, T1, T2>(arg0: &mut 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: &0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::RebalanceCap, arg7: &0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::version::assert_current_version(arg7);
        0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::assert_rebalance_cap<T0, T1, T2>(arg0, arg6, arg8);
        0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (v1, v2) = 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::slippage<T0, T1, T2>(arg0);
        if (arg4 && (0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::free_balance_a_val<T0, T1, T2>(arg0) > 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::free_threshold_a<T0, T1, T2>(arg0) || arg5 > 0)) {
            let v3 = if (arg5 == 0) {
                let (v4, _) = 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2>(arg0, arg1, 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::free_balance_a_val<T0, T1, T2>(arg0), true, 10);
                v4
            } else {
                arg5
            };
            let v6 = 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::get_free_balance_a<T0, T1, T2>(arg0);
            assert!(v3 <= 0x2::balance::value<T0>(&v6), 10);
            let (v7, v8) = 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::utils::swap<T0, T1>(arg2, arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v3), arg8), 0x2::coin::zero<T1>(arg8), true, true, v3, 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::utils::slippage_adjusted_sqrt_price(true, v1, v2, v0), arg3, arg8);
            let v9 = v8;
            0x2::coin::destroy_zero<T0>(v7);
            let v10 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
            let (v11, v12) = 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::get_position_tick_range<T0, T1, T2>(arg0);
            let (v13, v14, v15) = 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::utils::check_is_fix_coin_a(v11, v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), v10, 0x2::balance::value<T0>(&v6), 0x2::coin::value<T1>(&v9));
            let v16 = if (v13) {
                v14
            } else {
                v15
            };
            let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::position_borrow_mut<T0, T1, T2>(arg0), v16, v13, arg3);
            let (v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v17);
            let v20 = 0x2::coin::into_balance<T1>(v9);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, 0x2::balance::split<T0>(&mut v6, v18), 0x2::balance::split<T1>(&mut v20, v19), v17);
            0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::add_free_balance_a<T0, T1, T2>(arg0, v6);
            0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::add_free_balance_b<T0, T1, T2>(arg0, v20);
            let v21 = LpResidualEvent{
                vault_id          : 0x2::object::id<0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::Vault<T0, T1, T2>>(arg0),
                rebalance_cap_id  : 0x2::object::id<0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::RebalanceCap>(arg6),
                lp_coin_a         : v18,
                lp_coin_b         : v19,
                before_sqrt_price : v0,
                after_sqrt_price  : v10,
                is_a              : arg4,
                swap_amt          : v3,
                residual_coin_a   : 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::free_balance_a_val<T0, T1, T2>(arg0),
                residual_coin_b   : 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::free_balance_b_val<T0, T1, T2>(arg0),
            };
            0x2::event::emit<LpResidualEvent>(v21);
        };
        if (!arg4 && (0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::free_balance_b_val<T0, T1, T2>(arg0) > 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::free_threshold_b<T0, T1, T2>(arg0) || arg5 > 0)) {
            let v22 = if (arg5 == 0) {
                let (v23, _) = 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2>(arg0, arg1, 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::free_balance_b_val<T0, T1, T2>(arg0), false, 10);
                v23
            } else {
                arg5
            };
            let v25 = 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::get_free_balance_b<T0, T1, T2>(arg0);
            assert!(v22 <= 0x2::balance::value<T1>(&v25), 11);
            let (v26, v27) = 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::utils::swap<T0, T1>(arg2, arg1, 0x2::coin::zero<T0>(arg8), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v25, v22), arg8), false, true, v22, 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::utils::slippage_adjusted_sqrt_price(false, v1, v2, v0), arg3, arg8);
            let v28 = v26;
            0x2::coin::destroy_zero<T1>(v27);
            let v29 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
            let (v30, v31) = 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::get_position_tick_range<T0, T1, T2>(arg0);
            let (v32, v33, v34) = 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::utils::check_is_fix_coin_a(v30, v31, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg1), v29, 0x2::coin::value<T0>(&v28), 0x2::balance::value<T1>(&v25));
            let v35 = if (v32) {
                v33
            } else {
                v34
            };
            let v36 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::position_borrow_mut<T0, T1, T2>(arg0), v35, v32, arg3);
            let (v37, v38) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v36);
            let v39 = 0x2::coin::into_balance<T0>(v28);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, 0x2::balance::split<T0>(&mut v39, v37), 0x2::balance::split<T1>(&mut v25, v38), v36);
            0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::add_free_balance_b<T0, T1, T2>(arg0, v25);
            0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::add_free_balance_a<T0, T1, T2>(arg0, v39);
            let v40 = LpResidualEvent{
                vault_id          : 0x2::object::id<0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::Vault<T0, T1, T2>>(arg0),
                rebalance_cap_id  : 0x2::object::id<0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::RebalanceCap>(arg6),
                lp_coin_a         : v37,
                lp_coin_b         : v38,
                before_sqrt_price : v0,
                after_sqrt_price  : v29,
                is_a              : arg4,
                swap_amt          : v22,
                residual_coin_a   : 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::free_balance_a_val<T0, T1, T2>(arg0),
                residual_coin_b   : 0xb49c14ef41d3d350a66b7b9f7dcd2c9e179c5b3fdcb62db926f48d20ff9914d2::vault::free_balance_b_val<T0, T1, T2>(arg0),
            };
            0x2::event::emit<LpResidualEvent>(v40);
        };
    }

    // decompiled from Move bytecode v6
}

