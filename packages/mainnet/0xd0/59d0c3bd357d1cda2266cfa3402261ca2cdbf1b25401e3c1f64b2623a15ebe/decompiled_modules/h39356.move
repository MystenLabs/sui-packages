module 0xd059d0c3bd357d1cda2266cfa3402261ca2cdbf1b25401e3c1f64b2623a15ebe::h39356 {
    struct H18e94 has copy, drop {
        hb4d58: 0x2::object::ID,
        h2bda5: 0x2::object::ID,
        hf7f9c: u32,
        hf393b: u32,
        h247d9: u128,
        h0ea68: u64,
        hcb5b3: u64,
    }

    struct Heacc4 has copy, drop {
        hb4d58: 0x2::object::ID,
        h2bda5: 0x2::object::ID,
        h247d9: u128,
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

    public fun h9d1e6<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h2cb40<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1, 0, arg5);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v0);
        let (_, _, v4, v5) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg3, arg0, &mut v0, v1, arg4);
        let v6 = v5;
        let v7 = v4;
        let (_, _, v10, v11) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg4, arg3, arg0, &mut v0);
        let v12 = v11;
        let v13 = v10;
        let v14 = Heacc4{
            hb4d58 : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(&v0),
            h2bda5 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v0),
            h247d9 : v1,
            h8db35 : 0x2::balance::value<T0>(&v7),
            h02377 : 0x2::balance::value<T1>(&v6),
            hed73d : 0x2::balance::value<T0>(&v13),
            hf1140 : 0x2::balance::value<T1>(&v12),
        };
        0x2::event::emit<Heacc4>(v14);
        0x2::balance::join<T0>(&mut v7, v13);
        0x2::balance::join<T1>(&mut v6, v12);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg4, arg3, arg0, v0);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(v7, arg5), arg5);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T1>(arg1, arg2, 0x2::coin::from_balance<T1>(v6, arg5), arg5);
    }

    public fun hb4904<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::is_reward_present<T0, T1, T2>(arg0)) {
            let v0 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hb9332<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1, 0, arg5);
            let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg4, arg3, arg0, v0);
            let v2 = 0x2::balance::value<T2>(&v1);
            h8ecf2<T2>(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0), v2);
            if (v2 > 0) {
                0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T2>(arg1, arg2, 0x2::coin::from_balance<T2>(v1, arg5), arg5);
            } else {
                0x2::balance::destroy_zero<T2>(v1);
            };
        };
    }

    public fun hcb487<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg4) > arg13) {
            abort 13906834586660241409
        };
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h8d9ea(arg1, 0, arg14);
        let v0 = hd484f(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2), arg9, arg11);
        let v1 = hd484f(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), arg10, arg12);
        let v2 = if (arg8) {
            v0
        } else {
            v1
        };
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_tick_at_sqrt_price(v5);
        let v7 = if (arg8) {
            v1
        } else {
            v0
        };
        let (_, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_by_amount(v3, v4, v6, v5, h67fa3(arg7, v2), arg8);
        let v11 = v10;
        let v12 = v9;
        if (arg8 && v10 > v7 || v9 > v7) {
            let (_, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_by_amount(v3, v4, v6, v5, v7, !arg8);
            v11 = v15;
            v12 = v14;
        };
        assert!(v12 <= v0 && v11 <= v1, 13906834745574162435);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg3, arg0, arg5, arg6, arg14);
        let v17 = if (arg8) {
            v12
        } else {
            v11
        };
        let (_, _, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg4, arg3, arg0, &mut v16, 0x2::coin::into_balance<T0>(0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T0>(arg1, arg2, v12, arg14)), 0x2::coin::into_balance<T1>(0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T1>(arg1, arg2, v11, arg14)), v17, arg8);
        let v22 = v21;
        let v23 = v20;
        let v24 = H18e94{
            hb4d58 : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(&v16),
            h2bda5 : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v16),
            hf7f9c : arg5,
            hf393b : arg6,
            h247d9 : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v16),
            h0ea68 : v12 - 0x2::balance::value<T0>(&v23),
            hcb5b3 : v11 - 0x2::balance::value<T1>(&v22),
        };
        0x2::event::emit<H18e94>(v24);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(v23, arg14), arg14);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T1>(arg1, arg2, 0x2::coin::from_balance<T1>(v22, arg14), arg14);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::ha4cf0<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg1, 0, v16, arg14);
    }

    fun hd484f(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        };
        h67fa3(v0, arg2)
    }

    // decompiled from Move bytecode v6
}

