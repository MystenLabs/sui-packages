module 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::rebalance {
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

    public entry fun rebalance<T0, T1, T2>(arg0: &mut 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) - 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::last_rebalance_time<T0, T1, T2>(arg0) >= 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::min_rebalance_time<T0, T1, T2>(arg0), 0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1) != 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::last_rebalance_sqrt_price<T0, T1, T2>(arg0), 1);
        0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::collect::fees<T0, T1, T2>(arg0, arg1, arg2, arg4);
        let (v0, v1) = 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::utils::close_position<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::utils::create_position<T0, T1, T2>(arg0, arg1, arg2, &mut v3, &mut v2, arg3, arg4);
        0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::add_free_balance_a<T0, T1, T2>(arg0, v3);
        0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::add_free_balance_b<T0, T1, T2>(arg0, v2);
        lp_residual_amount<T0, T1, T2>(arg0, arg1, arg2, arg3, true, 0, arg4);
        lp_residual_amount<T0, T1, T2>(arg0, arg1, arg2, arg3, false, 0, arg4);
        0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::set_rebalance_time<T0, T1, T2>(arg0, 0x2::clock::timestamp_ms(arg3));
        emit_event(0x2::object::id<0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::Vault<T0, T1, T2>>(arg0), 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::free_balance_a_val<T0, T1, T2>(arg0), 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::free_balance_b_val<T0, T1, T2>(arg0), v4, v5, 0x2::clock::timestamp_ms(arg3), 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::last_rebalance_time<T0, T1, T2>(arg0));
    }

    fun calc_swap_amount(arg0: u64) : u64 {
        arg0 / 2
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

    public fun lp_residual_amount<T0, T1, T2>(arg0: &mut 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4 && 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::free_balance_a_val<T0, T1, T2>(arg0) > 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::free_threshold_a<T0, T1, T2>(arg0)) {
            let v0 = 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::get_free_balance_a<T0, T1, T2>(arg0);
            let v1 = if (arg5 == 0) {
                calc_swap_amount(0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::free_balance_a_val<T0, T1, T2>(arg0))
            } else {
                arg5
            };
            let (v2, v3) = 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::utils::swap<T0, T1>(arg2, arg1, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, v1), arg6), 0x2::coin::zero<T1>(arg6), true, true, v1, 4295048016, arg3, arg6);
            let v4 = v3;
            0x2::coin::destroy_zero<T0>(v2);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, v0, 0x2::coin::into_balance<T1>(v4), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::position_borrow_mut<T0, T1, T2>(arg0), 0x2::coin::value<T1>(&v4), false, arg3));
            let v5 = LpResidualEvent{
                vault_id        : 0x2::object::id<0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::Vault<T0, T1, T2>>(arg0),
                residual_coin_a : 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::free_balance_a_val<T0, T1, T2>(arg0),
                residual_coin_b : 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::free_balance_b_val<T0, T1, T2>(arg0),
            };
            0x2::event::emit<LpResidualEvent>(v5);
        };
        if (!arg4 && 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::free_balance_b_val<T0, T1, T2>(arg0) > 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::free_threshold_b<T0, T1, T2>(arg0)) {
            let v6 = 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::get_free_balance_b<T0, T1, T2>(arg0);
            let v7 = if (arg5 == 0) {
                calc_swap_amount(0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::free_balance_b_val<T0, T1, T2>(arg0))
            } else {
                arg5
            };
            let (v8, v9) = 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::utils::swap<T0, T1>(arg2, arg1, 0x2::coin::zero<T0>(arg6), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v6, v7), arg6), false, true, v7, 79226673515401279992447579055, arg3, arg6);
            let v10 = v8;
            0x2::coin::destroy_zero<T1>(v9);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg2, arg1, 0x2::coin::into_balance<T0>(v10), v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg2, arg1, 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::position_borrow_mut<T0, T1, T2>(arg0), 0x2::coin::value<T0>(&v10), true, arg3));
            let v11 = LpResidualEvent{
                vault_id        : 0x2::object::id<0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::Vault<T0, T1, T2>>(arg0),
                residual_coin_a : 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::free_balance_a_val<T0, T1, T2>(arg0),
                residual_coin_b : 0xdf7f12205ae05503dc2af3db0e9caf29e96881e4c6a79c8722fdb2df8eeb1ccb::vault::free_balance_b_val<T0, T1, T2>(arg0),
            };
            0x2::event::emit<LpResidualEvent>(v11);
        };
    }

    // decompiled from Move bytecode v6
}

