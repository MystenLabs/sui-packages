module 0x993c6e7650382fb44dfbc58596cccc9eb2de107c4af5f158a7f9b048ca9f8dc2::lp_bluefin {
    struct BluefinWitness has drop {
        dummy_field: bool,
    }

    public fun compound<T0, T1>(arg0: &mut 0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::compound_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg2));
        let (v1, v2, v3, v4, v5, v6) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), v0, arg8);
        assert!(v1 >= arg6 && v2 >= arg7, 1);
        let v7 = init_witness();
        0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::events::emit_compounded<BluefinWitness>(arg0, &v7, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg3), v1, v2, v3, v4);
        (0x2::coin::from_balance<T0>(v5, arg9), 0x2::coin::from_balance<T1>(v6, arg9))
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

    public fun rebalance<T0, T1>(arg0: &mut 0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u32, arg5: u32, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) {
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg3);
        let (v1, v2, v3, v4) = if (v0 > 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, v0, arg10)
        } else {
            (0, 0, 0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v5 = 0x2::coin::into_balance<T1>(arg7);
        let v6 = 0x2::coin::into_balance<T0>(arg6);
        0x2::balance::join<T0>(&mut v6, v3);
        0x2::balance::join<T1>(&mut v5, v4);
        let v7 = 0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::rebalance_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg2));
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg4, arg5, arg11);
        let v9 = &mut v8;
        let (v10, v11, v12, v13, v14, v15) = zap_in_int<T0, T1>(arg0, arg1, arg2, v9, v6, v5, v7, arg10);
        assert!(v10 >= arg8 && v11 >= arg9, 1);
        let v16 = init_witness();
        0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::events::emit_rebalanced<BluefinWitness>(arg0, &v16, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg3), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v8), v1, v2, v10, v11, v12, v13);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg10, arg1, arg2, arg3);
        (0x2::coin::from_balance<T0>(v14, arg11), 0x2::coin::from_balance<T1>(v15, arg11), v8)
    }

    fun swap_to_optimal<T0, T1>(arg0: &0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock) {
        let (v0, v1, v2, _) = 0x993c6e7650382fb44dfbc58596cccc9eb2de107c4af5f158a7f9b048ca9f8dc2::swap_math::optimal_swap<T0, T1>(arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg3)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg3)), 0x2::balance::value<T0>(arg4), 0x2::balance::value<T1>(arg5));
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
        0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::assert_price(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2));
        let v11 = if (v2) {
            0x2::balance::value<T1>(&v9)
        } else {
            0x2::balance::value<T0>(&v10)
        };
        0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::assert_output(arg0, v1, v11);
        0x2::balance::join<T0>(arg4, v10);
        0x2::balance::join<T1>(arg5, v9);
    }

    public fun zap_in<T0, T1>(arg0: &mut 0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::zap_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg2));
        let (v1, v2, v3, v4, v5, v6) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), v0, arg8);
        assert!(v1 >= arg6 && v2 >= arg7, 1);
        let v7 = init_witness();
        0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::events::emit_zapped<BluefinWitness>(arg0, &v7, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg3), v1, v2, v3, v4, true);
        (0x2::coin::from_balance<T0>(v5, arg9), 0x2::coin::from_balance<T1>(v6, arg9))
    }

    fun zap_in_int<T0, T1>(arg0: &mut 0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: &0x2::clock::Clock) : (u64, u64, u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::collect_fees<T0, T1>(arg0, &mut arg4, &mut arg5, arg6);
        let v2 = &mut arg4;
        let v3 = &mut arg5;
        swap_to_optimal<T0, T1>(arg0, arg1, arg2, arg3, v2, v3, arg7);
        let v4 = 0x2::balance::value<T0>(&arg4);
        let v5 = 0x2::balance::value<T1>(&arg5);
        assert!(v4 > 0 || v5 > 0, 0);
        let (v6, v7, v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T0, T1>(arg7, arg1, arg2, arg3, arg4, arg5, liquidity_for_amounts(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg3)), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg3)), v4, v5));
        (v6, v7, v0, v1, v8, v9)
    }

    public fun zap_out<T0, T1>(arg0: &mut 0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::into_balance<T1>(arg4);
        let v1 = 0x2::coin::into_balance<T0>(arg3);
        let (v2, v3) = 0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::collect_fees<T0, T1>(arg0, &mut v1, &mut v0, 0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::registry::zap_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg1)));
        let v4 = init_witness();
        0x1dca0c0342173639a8dcc6bea6aaa36eade8bf4c4a558918902fc2924a9ffc31::events::emit_zapped<BluefinWitness>(arg0, &v4, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg2), 0x2::balance::value<T0>(&v1), 0x2::balance::value<T1>(&v0), v2, v3, false);
        (0x2::coin::from_balance<T0>(v1, arg5), 0x2::coin::from_balance<T1>(v0, arg5))
    }

    // decompiled from Move bytecode v6
}

