module 0x6e4d200dd0965dda9c9ff6aedabf162853debf7133bd5f638a675156204c9076::h39356 {
    struct H18e94 has copy, drop {
        h2bda5: 0x2::object::ID,
        hf7f9c: u32,
        hf393b: u32,
        h0ea68: u64,
        hcb5b3: u64,
    }

    struct Heacc4 has copy, drop {
        h2bda5: 0x2::object::ID,
        h8db35: u64,
        h02377: u64,
        hed73d: u64,
        hf1140: u64,
    }

    struct H70cf0 has copy, drop {
        h2bda5: 0x2::object::ID,
        hca92a: 0x1::ascii::String,
        h1d492: u64,
    }

    fun h67fa3(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg1
        } else {
            arg0
        }
    }

    fun h8ecf2<T0>(arg0: 0x2::object::ID, arg1: u64) {
        if (arg1 > 0) {
            let v0 = H70cf0{
                h2bda5 : arg0,
                hca92a : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
                h1d492 : arg1,
            };
            0x2::event::emit<H70cf0>(v0);
        };
    }

    public fun h9d1e6<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg0, &mut arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg3), arg4);
        let v4 = v3;
        let v5 = v2;
        let (_, _, v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg4, arg2, arg0, &mut arg3);
        let v10 = v9;
        let v11 = v8;
        let v12 = Heacc4{
            h2bda5 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg3),
            h8db35 : 0x2::balance::value<T0>(&v5),
            h02377 : 0x2::balance::value<T1>(&v4),
            hed73d : 0x2::balance::value<T0>(&v11),
            hf1140 : 0x2::balance::value<T1>(&v10),
        };
        0x2::event::emit<Heacc4>(v12);
        0x2::balance::join<T0>(&mut v5, v11);
        0x2::balance::join<T1>(&mut v4, v10);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg4, arg2, arg0, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, 0x2::coin::from_balance<T0>(v5, arg5), arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, 0x2::coin::from_balance<T1>(v4, arg5), arg5);
    }

    public fun hb4904<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::is_reward_present<T0, T1, T2>(arg0)) {
            let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg4, arg2, arg0, arg3);
            let v1 = 0x2::balance::value<T2>(&v0);
            h8ecf2<T2>(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg3), v1);
            if (v1 > 0) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T2>(arg1, 0x2::coin::from_balance<T2>(v0, arg5), arg5);
            } else {
                0x2::balance::destroy_zero<T2>(v0);
            };
        };
    }

    public fun hcb487<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: u32, arg5: u32, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: bool, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        if (0x2::clock::timestamp_ms(arg3) > arg11) {
            abort 13906834526530699265
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v2 = if (arg10) {
            if (v0 > arg8) {
                v0 - arg8
            } else {
                0
            }
        } else if (v0 > arg9) {
            v0 - arg9
        } else {
            0
        };
        let v3 = if (arg10) {
            if (v1 > arg9) {
                v1 - arg9
            } else {
                0
            }
        } else if (v1 > arg8) {
            v1 - arg8
        } else {
            0
        };
        let v4 = if (arg7) {
            v2
        } else {
            v3
        };
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        let v7 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_tick_at_sqrt_price(v7);
        let v9 = if (arg7) {
            v3
        } else {
            v2
        };
        let (_, v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_by_amount(v5, v6, v8, v7, h67fa3(arg6, v4), arg7);
        let v13 = v12;
        let v14 = v11;
        if (arg7 && v12 > v9 || v11 > v9) {
            let (_, v16, v17) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_by_amount(v5, v6, v8, v7, v9, !arg7);
            v13 = v17;
            v14 = v16;
        };
        assert!(v14 <= v2 && v13 <= v3, 13906834732689260547);
        let v18 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg0, arg4, arg5, arg12);
        let v19 = if (arg7) {
            v14
        } else {
            v13
        };
        let (_, _, v22, v23) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg3, arg2, arg0, &mut v18, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, v14, arg12)), 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg1, v13, arg12)), v19, arg7);
        let v24 = v23;
        let v25 = v22;
        let v26 = H18e94{
            h2bda5 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v18),
            hf7f9c : arg4,
            hf393b : arg5,
            h0ea68 : v14 - 0x2::balance::value<T0>(&v25),
            hcb5b3 : v13 - 0x2::balance::value<T1>(&v24),
        };
        0x2::event::emit<H18e94>(v26);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, 0x2::coin::from_balance<T0>(v25, arg12), arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, 0x2::coin::from_balance<T1>(v24, arg12), arg12);
        v18
    }

    // decompiled from Move bytecode v6
}

