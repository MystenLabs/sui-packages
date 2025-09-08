module 0x74f9da86d74802dc51152c9ae99d23a5f84503c1eadf1d39f0fadc05feaa5091::lp_bluefin {
    struct BluefinWitness has drop {
        dummy_field: bool,
    }

    public fun compound<T0, T1>(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::FeeCollector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = if (0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::contains_keeper(arg0, 0x2::tx_context::sender(arg10))) {
            let v0 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::auto_compound_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg3));
            (v0, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::constants::auto_compound_source())
        } else {
            let v0 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::compound_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg3));
            (v0, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::constants::compound_source())
        };
        let (v2, v3, v4, v5) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), 0x2::coin::into_balance<T1>(arg6), v1, v0, arg9);
        assert!(v2 >= arg7 && v3 >= arg8, 1);
        let v6 = mint_proxy_cap(arg0);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::events::emit_compounded(&v6, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg4), v2, v3);
        (0x2::coin::from_balance<T0>(v4, arg10), 0x2::coin::from_balance<T1>(v5, arg10))
    }

    fun init_witness() : BluefinWitness {
        BluefinWitness{dummy_field: false}
    }

    fun liquidity_for_amounts(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : u128 {
        if (arg0 <= arg1) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_from_a(arg1, arg2, arg3, false)
        } else if (arg0 >= arg2) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_from_b(arg1, arg2, arg4, false)
        } else {
            0x1::u128::min(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_from_a(arg0, arg2, arg3, false), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_from_b(arg1, arg0, arg4, false))
        }
    }

    public(friend) fun mint_proxy_cap(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry) : 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::ProxyCap {
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::mint_proxy_cap<BluefinWitness>(arg0, init_witness())
    }

    public fun rebalance<T0, T1>(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::FeeCollector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) {
        let v0 = 0x2::coin::value<T0>(&arg7) > 0 || 0x2::coin::value<T1>(&arg8) > 0;
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg4);
        let (v2, v3, v4, v5) = if (v1 > 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg3, &mut arg4, v1, arg11)
        } else {
            (0, 0, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v6 = 0x2::coin::into_balance<T1>(arg8);
        let v7 = 0x2::coin::into_balance<T0>(arg7);
        0x2::balance::join<T0>(&mut v7, v4);
        0x2::balance::join<T1>(&mut v6, v5);
        let (v8, v9) = if (0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::contains_keeper(arg0, 0x2::tx_context::sender(arg12))) {
            let v8 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::auto_rebalance_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg3));
            (v8, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::constants::auto_rebalance_source())
        } else {
            let v8 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::rebalance_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg3));
            (v8, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::constants::rebalance_source())
        };
        let v10 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg3, arg5, arg6, arg12);
        let v11 = &mut v10;
        let (v12, v13, v14, v15) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, v11, v7, v6, v9, v8, arg11);
        assert!(v12 >= arg9 && v13 >= arg10, 1);
        let v16 = mint_proxy_cap(arg0);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::events::emit_rebalanced(&v16, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg4), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v10), v2, v3, v12, v13, v0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg11, arg2, arg3, arg4);
        (0x2::coin::from_balance<T0>(v14, arg12), 0x2::coin::from_balance<T1>(v15, arg12), v10)
    }

    fun swap_to_optimal<T0, T1>(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock) {
        let (v0, v1, v2, _) = 0x74f9da86d74802dc51152c9ae99d23a5f84503c1eadf1d39f0fadc05feaa5091::swap_math::optimal_swap<T0, T1>(arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg3)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg3)), 0x2::balance::value<T0>(arg4), 0x2::balance::value<T1>(arg5));
        if (v0 == 0 && v1 == 0) {
            return
        };
        let (v4, v5, v6) = if (v2) {
            (0x2::balance::split<T0>(arg4, v0), 0x2::balance::zero<T1>(), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_sqrt_price() + 1)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg5, v0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_sqrt_price() - 1)
        };
        let (v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg6, arg1, arg2, v4, v5, v2, true, v0, 0, v6);
        let v9 = v8;
        let v10 = v7;
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::assert_price(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2));
        let v11 = if (v2) {
            0x2::balance::value<T1>(&v9)
        } else {
            0x2::balance::value<T0>(&v10)
        };
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::assert_output(arg0, v1, v11);
        0x2::balance::join<T0>(arg4, v10);
        0x2::balance::join<T1>(arg5, v9);
    }

    public fun zap_in<T0, T1>(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::FeeCollector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::zap_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg3));
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), 0x2::coin::into_balance<T1>(arg6), 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::constants::zap_in_source(), v0, arg9);
        assert!(v1 >= arg7 && v2 >= arg8, 1);
        let v5 = mint_proxy_cap(arg0);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::events::emit_zapped_in(&v5, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg4), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg10), 0x2::coin::from_balance<T1>(v4, arg10))
    }

    fun zap_in_int<T0, T1>(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::FeeCollector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::collect_fees<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, T0>(arg1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), &mut arg5, arg7, arg8);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::collect_fees<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, T1>(arg1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), &mut arg6, arg7, arg8);
        let v0 = &mut arg5;
        let v1 = &mut arg6;
        swap_to_optimal<T0, T1>(arg0, arg2, arg3, arg4, v0, v1, arg9);
        let v2 = 0x2::balance::value<T0>(&arg5);
        let v3 = 0x2::balance::value<T1>(&arg6);
        assert!(v2 > 0 || v3 > 0, 0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T0, T1>(arg9, arg2, arg3, arg4, arg5, arg6, liquidity_for_amounts(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg4)), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg4)), v2, v3))
    }

    public fun zap_out<T0, T1, T2>(arg0: &0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::Registry, arg1: &mut 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::FeeCollector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::into_balance<T2>(arg4);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::lp_registry::collect_fees<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, T2>(arg1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), &mut v0, 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::constants::zap_out_source(), 0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::registry::zap_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg2)));
        assert!(0x2::balance::value<T2>(&v0) >= arg5, 1);
        let v1 = mint_proxy_cap(arg0);
        0xa3f96ab962aedd82296034914c9673c6711000b82ca6939dbac5079192e26c08::events::emit_zapped_out(&v1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg3), 0x1::type_name::get<T2>(), 0x2::balance::value<T2>(&v0));
        0x2::coin::from_balance<T2>(v0, arg6)
    }

    // decompiled from Move bytecode v6
}

