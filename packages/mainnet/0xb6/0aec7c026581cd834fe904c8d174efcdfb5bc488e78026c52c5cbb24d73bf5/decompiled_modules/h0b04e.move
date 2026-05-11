module 0xb60aec7c026581cd834fe904c8d174efcdfb5bc488e78026c52c5cbb24d73bf5::h0b04e {
    struct H078b8 has copy, drop {
        hf3e16: u64,
        h82c87: u32,
        hccff3: u32,
        hfe881: u64,
        h557c5: u64,
    }

    struct Ha6c02 has copy, drop {
        hf3e16: u64,
        h07e98: u64,
        h9bdfe: u64,
        hb3e62: u64,
        hd500f: u64,
    }

    struct H88e6e has copy, drop {
        hf3e16: u64,
        hb3e62: u64,
        hd500f: u64,
    }

    struct H4abc1 has copy, drop {
        hf3e16: u64,
        h5eca4: 0x1::ascii::String,
        h76aff: u64,
    }

    fun h15cd4(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg1
        } else {
            arg0
        }
    }

    public fun h1fedc<T0, T1, T2>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::is_reward_present<T0, T1, T2>(arg0)) {
            let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg5, arg2, arg0, arg3);
            let v1 = 0x2::balance::value<T2>(&v0);
            h621a5<T2>(arg4, v1);
            if (v1 > 0) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T2>(arg1, 0x2::coin::from_balance<T2>(v0, arg6), arg6);
            } else {
                0x2::balance::destroy_zero<T2>(v0);
            };
        };
    }

    fun h472d8(arg0: u64, arg1: u64, arg2: u64) {
        if (arg1 > 0 || arg2 > 0) {
            let v0 = H88e6e{
                hf3e16 : arg0,
                hb3e62 : arg1,
                hd500f : arg2,
            };
            0x2::event::emit<H88e6e>(v0);
        };
    }

    public fun h4c6ac<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg5, arg2, arg0, arg3);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        h472d8(arg4, v6, v7);
        if (v6 > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, 0x2::coin::from_balance<T0>(v5, arg6), arg6);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        if (v7 > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, 0x2::coin::from_balance<T1>(v4, arg6), arg6);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
    }

    fun h621a5<T0>(arg0: u64, arg1: u64) {
        if (arg1 > 0) {
            let v0 = H4abc1{
                hf3e16 : arg0,
                h5eca4 : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
                h76aff : arg1,
            };
            0x2::event::emit<H4abc1>(v0);
        };
    }

    public fun h6f5e3<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &0x2::clock::Clock, arg4: u32, arg5: u32, arg6: u64, arg7: bool, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        if (0x2::clock::timestamp_ms(arg3) > arg8) {
            abort 13906834565185404929
        };
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1);
        let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1);
        let v2 = if (arg7) {
            v0
        } else {
            v1
        };
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg4);
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        let v5 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v6 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_tick_at_sqrt_price(v5);
        let v7 = if (arg7) {
            v1
        } else {
            v0
        };
        let (_, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_by_amount(v3, v4, v6, v5, h15cd4(arg6, v2), arg7);
        let v11 = v10;
        let v12 = v9;
        if (arg7 && v10 > v7 || v9 > v7) {
            let (_, v14, v15) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::get_liquidity_by_amount(v3, v4, v6, v5, v7, !arg7);
            v11 = v15;
            v12 = v14;
        };
        assert!(v12 <= v0 && v11 <= v1, 13906834715509391363);
        let v16 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg0, arg4, arg5, arg10);
        let v17 = if (arg7) {
            v12
        } else {
            v11
        };
        let (_, _, v20, v21) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg3, arg2, arg0, &mut v16, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, v12, arg10)), 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg1, v11, arg10)), v17, arg7);
        let v22 = v21;
        let v23 = v20;
        let v24 = H078b8{
            hf3e16 : arg9,
            h82c87 : arg4,
            hccff3 : arg5,
            hfe881 : v12 - 0x2::balance::value<T0>(&v23),
            h557c5 : v11 - 0x2::balance::value<T1>(&v22),
        };
        0x2::event::emit<H078b8>(v24);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, 0x2::coin::from_balance<T0>(v23, arg10), arg10);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, 0x2::coin::from_balance<T1>(v22, arg10), arg10);
        v16
    }

    public fun hd36e1<T0, T1>(arg0: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, _, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg2, arg0, &mut arg3, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&arg3), arg5);
        let v4 = v3;
        let v5 = v2;
        let (_, _, v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg5, arg2, arg0, &mut arg3);
        let v10 = v9;
        let v11 = v8;
        let v12 = Ha6c02{
            hf3e16 : arg4,
            h07e98 : 0x2::balance::value<T0>(&v5),
            h9bdfe : 0x2::balance::value<T1>(&v4),
            hb3e62 : 0x2::balance::value<T0>(&v11),
            hd500f : 0x2::balance::value<T1>(&v10),
        };
        0x2::event::emit<Ha6c02>(v12);
        0x2::balance::join<T0>(&mut v5, v11);
        0x2::balance::join<T1>(&mut v4, v10);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg5, arg2, arg0, arg3);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, 0x2::coin::from_balance<T0>(v5, arg6), arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg1, 0x2::coin::from_balance<T1>(v4, arg6), arg6);
    }

    // decompiled from Move bytecode v6
}

