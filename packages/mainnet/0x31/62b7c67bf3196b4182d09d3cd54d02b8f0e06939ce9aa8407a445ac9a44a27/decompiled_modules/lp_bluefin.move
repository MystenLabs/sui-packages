module 0x3162b7c67bf3196b4182d09d3cd54d02b8f0e06939ce9aa8407a445ac9a44a27::lp_bluefin {
    public fun rebalance<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: u32, arg4: u32, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg2);
        let (v1, v2, v3, v4) = if (v0 > 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg0, arg1, &mut arg2, v0, arg7)
        } else {
            (0, 0, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v5 = v4;
        let v6 = v3;
        let (_, _, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg7, arg0, arg1, &mut arg2);
        let v11 = v10;
        let v12 = v9;
        if (arg6) {
            0x2::balance::join<T0>(&mut v6, 0x2::balance::withdraw_all<T0>(&mut v12));
            0x2::balance::join<T1>(&mut v5, 0x2::balance::withdraw_all<T1>(&mut v11));
        };
        let v13 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg0, arg1, arg3, arg4, arg8);
        let v14 = &mut v13;
        let (v15, v16, v17, v18) = zap_in_int<T0, T1>(arg0, arg1, v14, v6, v5, arg5, arg7);
        let v19 = v18;
        let v20 = v17;
        0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::events::emit_rebalanced(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v13), v1, v2, v15, v16, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(&arg2)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(&arg2)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(&v13)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(&v13)), v0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v13));
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg7, arg0, arg1, arg2);
        0x2::balance::join<T0>(&mut v20, v12);
        0x2::balance::join<T1>(&mut v19, v11);
        (0x2::coin::from_balance<T0>(v20, arg8), 0x2::coin::from_balance<T1>(v19, arg8), v13)
    }

    fun swap_to_optimal<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1, v2, v3) = 0x3162b7c67bf3196b4182d09d3cd54d02b8f0e06939ce9aa8407a445ac9a44a27::swap_math::optimal_swap<T0, T1>(arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg2)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg2)), 0x2::balance::value<T0>(&arg3), 0x2::balance::value<T1>(&arg4));
        if (v0 == 0 && v1 == 0) {
            return (arg3, arg4)
        };
        let (v4, v5) = if (v2) {
            (0x2::balance::split<T0>(&mut arg3, v0), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg4, v0))
        };
        let v6 = if (v2) {
            v3 - 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::safe_math::mul_div_u128(v3, 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::constants::max_fee_pips_u128() - (arg5 as u128), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::constants::max_fee_pips_u128())
        } else {
            v3 + 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::safe_math::mul_div_u128(v3, 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::constants::max_fee_pips_u128() - (arg5 as u128), 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::constants::max_fee_pips_u128())
        };
        let (v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg6, arg0, arg1, v4, v5, v2, true, v0, 0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::constants::amount_after_fee(v1, arg5), v6);
        0x2::balance::join<T0>(&mut arg3, v7);
        0x2::balance::join<T1>(&mut arg4, v8);
        (arg3, arg4)
    }

    public fun zap_in<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2, v3) = zap_in_int<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg5, arg6);
        0x639459138d90b1ceee644caf5b8029efa6460f6dffa281fd931c9ad6ad050279::events::emit_zapped_in(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg2), v0, v1);
        (v0, v1, 0x2::coin::from_balance<T0>(v2, arg7), 0x2::coin::from_balance<T1>(v3, arg7))
    }

    fun zap_in_int<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: u64, arg6: &0x2::clock::Clock) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = swap_to_optimal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<T0>(&v3);
        let v5 = 0x2::balance::value<T1>(&v2);
        assert!(v4 > 0 || v5 > 0, 0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T0, T1>(arg6, arg0, arg1, arg2, v3, v2, 0x3162b7c67bf3196b4182d09d3cd54d02b8f0e06939ce9aa8407a445ac9a44a27::liquidity_math::liquidity_for_amounts(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg2)), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg2)), v4, v5))
    }

    // decompiled from Move bytecode v6
}

