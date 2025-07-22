module 0xa859f5c79afd592a37b9ad5efd84c6bf8e1a625142f821384ca7a1b58bb49287::lp_bluefin {
    struct BluefinWitness has drop {
        dummy_field: bool,
    }

    public fun compound<T0, T1>(arg0: &mut 0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::registry::compound_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg2));
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), 0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::constants::compound_fee_source(), v0, arg8);
        assert!(v1 >= arg6 && v2 >= arg7, 1);
        let v5 = init_witness();
        0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::events::emit_compounded<BluefinWitness>(arg0, &v5, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg3), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg9), 0x2::coin::from_balance<T1>(v4, arg9))
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

    public fun rebalance<T0, T1>(arg0: &mut 0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u32, arg5: u32, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position) {
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
        let v7 = 0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::registry::rebalance_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg2));
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg1, arg2, arg4, arg5, arg11);
        let v9 = &mut v8;
        let (v10, v11, v12, v13) = zap_in_int<T0, T1>(arg0, arg1, arg2, v9, v6, v5, 0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::constants::rebalance_fee_source(), v7, arg10);
        assert!(v10 >= arg8 && v11 >= arg9, 1);
        let v14 = init_witness();
        0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::events::emit_rebalanced<BluefinWitness>(arg0, &v14, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg3), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v8), v1, v2, v10, v11);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg10, arg1, arg2, arg3);
        (0x2::coin::from_balance<T0>(v12, arg11), 0x2::coin::from_balance<T1>(v13, arg11), v8)
    }

    fun swap_to_optimal<T0, T1>(arg0: &0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock) {
        let (v0, v1, v2, _) = 0xa859f5c79afd592a37b9ad5efd84c6bf8e1a625142f821384ca7a1b58bb49287::swap_math::optimal_swap<T0, T1>(arg2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg3)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg3)), 0x2::balance::value<T0>(arg4), 0x2::balance::value<T1>(arg5));
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
        0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::registry::assert_price(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2));
        let v11 = if (v2) {
            0x2::balance::value<T1>(&v9)
        } else {
            0x2::balance::value<T0>(&v10)
        };
        0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::registry::assert_output(arg0, v1, v11);
        0x2::balance::join<T0>(arg4, v10);
        0x2::balance::join<T1>(arg5, v9);
    }

    public fun zap_in<T0, T1>(arg0: &mut 0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::registry::zap_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg2));
        let (v1, v2, v3, v4) = zap_in_int<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), 0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::constants::zap_in_fee_source(), v0, arg8);
        assert!(v1 >= arg6 && v2 >= arg7, 1);
        let v5 = init_witness();
        0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::events::emit_zapped_in<BluefinWitness>(arg0, &v5, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg3), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg9), 0x2::coin::from_balance<T1>(v4, arg9))
    }

    fun zap_in_int<T0, T1>(arg0: &mut 0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::registry::collect_fees<T0>(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), &mut arg4, arg6, arg7);
        0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::registry::collect_fees<T1>(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg2), &mut arg5, arg6, arg7);
        let v0 = &mut arg4;
        let v1 = &mut arg5;
        swap_to_optimal<T0, T1>(arg0, arg1, arg2, arg3, v0, v1, arg8);
        let v2 = 0x2::balance::value<T0>(&arg4);
        let v3 = 0x2::balance::value<T1>(&arg5);
        assert!(v2 > 0 || v3 > 0, 0);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T0, T1>(arg8, arg1, arg2, arg3, arg4, arg5, liquidity_for_amounts(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(arg3)), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(arg3)), v2, v3))
    }

    public fun zap_out<T0, T1, T2>(arg0: &mut 0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::registry::Registry, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: 0x2::coin::Coin<T2>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::into_balance<T2>(arg3);
        0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::registry::collect_fees<T2>(arg0, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), &mut v0, 0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::constants::zap_out_fee_source(), 0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::registry::zap_fee_pips(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg1)));
        let v1 = init_witness();
        0xbf967495248de88d8f64f927c16206598516deccc81ab52f5c8d31a3d5466f81::events::emit_zapped_out<BluefinWitness>(arg0, &v1, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg2), 0x1::type_name::get<T2>(), 0x2::balance::value<T2>(&v0));
        0x2::coin::from_balance<T2>(v0, arg4)
    }

    // decompiled from Move bytecode v6
}

