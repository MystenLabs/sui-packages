module 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::rebalance {
    struct RebalanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        residual_coin_a: u64,
        residual_coin_b: u64,
        lower_tick: u32,
        upper_tick: u32,
        timestamp_ms: u64,
        last_rebalance_time: u64,
    }

    struct LpResidualEvent has copy, drop {
        vault_id: 0x2::object::ID,
        residual_coin_a: u64,
        residual_coin_b: u64,
    }

    public entry fun rebalance<T0, T1, T2>(arg0: &mut 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        assert!(0x2::clock::timestamp_ms(arg3) - 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::last_rebalance_time<T0, T1, T2>(arg0) >= 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::min_rebalance_time<T0, T1, T2>(arg0), 0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) != 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::last_rebalance_sqrt_price<T0, T1, T2>(arg0), 1);
        0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::collect::fees<T0, T1, T2>(arg0, arg1, arg2, arg4);
        let (v0, v1) = 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::utils::close_position<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::utils::create_position<T0, T1, T2>(arg0, arg1, arg2, &mut v3, &mut v2, arg3, arg4);
        0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::update_ticks_info<T0, T1, T2>(arg0, v4, v5);
        0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::add_free_balance_a<T0, T1, T2>(arg0, v3);
        0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::add_free_balance_b<T0, T1, T2>(arg0, v2);
        lp_residual_amount<T0, T1, T2>(arg0, arg1, arg2, arg3, true, 0, arg4);
        lp_residual_amount<T0, T1, T2>(arg0, arg1, arg2, arg3, false, 0, arg4);
        0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::set_rebalance_time<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg3));
        emit_event(0x2::object::id<0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::Vault<T0, T1, T2>>(arg0), 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::free_balance_a_val<T0, T1, T2>(arg0), 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::free_balance_b_val<T0, T1, T2>(arg0), v4, v5, 0x2::clock::timestamp_ms(arg3), 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::last_rebalance_time<T0, T1, T2>(arg0));
    }

    fun emit_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u32, arg4: u32, arg5: u64, arg6: u64) {
        let v0 = RebalanceEvent{
            vault_id            : arg0,
            residual_coin_a     : arg1,
            residual_coin_b     : arg2,
            lower_tick          : arg3,
            upper_tick          : arg4,
            timestamp_ms        : arg5,
            last_rebalance_time : arg6,
        };
        0x2::event::emit<RebalanceEvent>(v0);
    }

    public fun lp_residual_amount<T0, T1, T2>(arg0: &mut 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        if (arg4 && (0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::free_balance_a_val<T0, T1, T2>(arg0) > 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::free_threshold_a<T0, T1, T2>(arg0) || arg5 > 0)) {
            let (v0, v1) = if (arg5 == 0) {
                0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2>(arg0, arg1, 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::free_balance_a_val<T0, T1, T2>(arg0), true, 10)
            } else {
                (arg5, false)
            };
            let v2 = 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::get_free_balance_a<T0, T1, T2>(arg0);
            assert!(v0 <= 0x2::balance::value<T0>(&v2), 10);
            let (v3, v4) = 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::utils::swap<T0, T1>(arg2, arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v0), arg6), 0x2::coin::zero<T1>(arg6), true, true, v0, 4295048016, arg3, arg6);
            let v5 = v4;
            0x2::coin::destroy_zero<T0>(v3);
            let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::position_borrow_mut<T0, T1, T2>(arg0), 0x2::coin::value<T1>(&v5), v1, arg3);
            let (v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v6);
            let v9 = 0x2::coin::into_balance<T1>(v5);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, 0x2::balance::split<T0>(&mut v2, v7), 0x2::balance::split<T1>(&mut v9, v8), v6);
            0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::add_free_balance_a<T0, T1, T2>(arg0, v2);
            0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::add_free_balance_b<T0, T1, T2>(arg0, v9);
            let v10 = LpResidualEvent{
                vault_id        : 0x2::object::id<0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::Vault<T0, T1, T2>>(arg0),
                residual_coin_a : 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::free_balance_a_val<T0, T1, T2>(arg0),
                residual_coin_b : 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::free_balance_b_val<T0, T1, T2>(arg0),
            };
            0x2::event::emit<LpResidualEvent>(v10);
        };
        if (!arg4 && (0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::free_balance_b_val<T0, T1, T2>(arg0) > 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::free_threshold_b<T0, T1, T2>(arg0) || arg5 > 0)) {
            let (v11, v12) = if (arg5 == 0) {
                0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2>(arg0, arg1, 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::free_balance_b_val<T0, T1, T2>(arg0), false, 10)
            } else {
                (arg5, false)
            };
            let v13 = 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::get_free_balance_b<T0, T1, T2>(arg0);
            assert!(v11 <= 0x2::balance::value<T1>(&v13), 11);
            let (v14, v15) = 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::utils::swap<T0, T1>(arg2, arg1, 0x2::coin::zero<T0>(arg6), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v13, v11), arg6), false, true, v11, 79226673515401279992447579055, arg3, arg6);
            let v16 = v14;
            0x2::coin::destroy_zero<T1>(v15);
            let v17 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::position_borrow_mut<T0, T1, T2>(arg0), 0x2::coin::value<T0>(&v16), v12, arg3);
            let (v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v17);
            let v20 = 0x2::coin::into_balance<T0>(v16);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, 0x2::balance::split<T0>(&mut v20, v18), 0x2::balance::split<T1>(&mut v13, v19), v17);
            0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::add_free_balance_b<T0, T1, T2>(arg0, v13);
            0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::add_free_balance_a<T0, T1, T2>(arg0, v20);
            let v21 = LpResidualEvent{
                vault_id        : 0x2::object::id<0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::Vault<T0, T1, T2>>(arg0),
                residual_coin_a : 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::free_balance_a_val<T0, T1, T2>(arg0),
                residual_coin_b : 0xb662fbfaef7c1eec7cdadacd9fa9daa47a62244f525dd206e915a962b0af414f::vault::free_balance_b_val<T0, T1, T2>(arg0),
            };
            0x2::event::emit<LpResidualEvent>(v21);
        };
    }

    // decompiled from Move bytecode v6
}

