module 0xb92078d1a32be59fd60897d39911cfffb442ec195a445b7a1866e68837aa4291::h147c2 {
    struct Hedc59 has copy, drop {
        hd5f7d: 0x2::object::ID,
        h668c7: 0x2::object::ID,
        he3ea7: u32,
        h443d9: u32,
        hcf99a: u128,
        he214c: u64,
        h7b14f: u64,
    }

    struct H7700e has copy, drop {
        hd5f7d: 0x2::object::ID,
        h668c7: 0x2::object::ID,
        hcf99a: u128,
        h6852f: u64,
        h975d1: u64,
        h280f6: u64,
        h27466: u64,
    }

    struct Hc1af8 has copy, drop {
        h668c7: 0x2::object::ID,
        h3ec5e: 0x1::ascii::String,
        h0db5d: u64,
    }

    public fun h0624e<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h2cb40<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, 0, arg5);
        let v1 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v0);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg3, arg0, &mut v0, v1, arg4);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg3, arg0, &v0, false);
        let v8 = v7;
        let v9 = v6;
        let v10 = H7700e{
            hd5f7d : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v0),
            h668c7 : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            hcf99a : v1,
            h6852f : 0x2::balance::value<T0>(&v5),
            h975d1 : 0x2::balance::value<T1>(&v4),
            h280f6 : 0x2::balance::value<T0>(&v9),
            h27466 : 0x2::balance::value<T1>(&v8),
        };
        0x2::event::emit<H7700e>(v10);
        0x2::balance::join<T0>(&mut v5, v9);
        0x2::balance::join<T1>(&mut v4, v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, T1>(arg3, arg0, v0);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(v5, arg5), arg5);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T1>(arg1, arg2, 0x2::coin::from_balance<T1>(v4, arg5), arg5);
    }

    fun h0d17b(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        };
        heed14(v0, arg2)
    }

    public fun h6b02e<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg4) > arg13) {
            abort 13906834582365274113
        };
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h8d9ea(arg1, 0, arg14);
        let v0 = h0d17b(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2), arg9, arg11);
        let v1 = h0d17b(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), arg10, arg12);
        let v2 = if (arg8) {
            v0
        } else {
            v1
        };
        let v3 = if (arg8) {
            v1
        } else {
            v0
        };
        let v4 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0);
        let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0);
        let (_, v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v4, v5, v6, v7, heed14(arg7, v2), arg8);
        let v11 = v10;
        let v12 = v9;
        let v13 = arg8;
        if (v9 > v0 || v10 > v1) {
            let (_, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_liquidity_from_amount(v4, v5, v6, v7, v3, !arg8);
            v11 = v16;
            v12 = v15;
            v13 = !arg8;
        };
        assert!(v12 <= v0 && v11 <= v1, 13906834749869129731);
        let v17 = if (v13) {
            v12
        } else {
            v11
        };
        let v18 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg3, arg0, arg5, arg6, arg14);
        let v19 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg3, arg0, &mut v18, v17, v13, arg4);
        let (v20, v21) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v19);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg3, arg0, 0x2::coin::into_balance<T0>(0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T0>(arg1, arg2, v20, arg14)), 0x2::coin::into_balance<T1>(0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T1>(arg1, arg2, v21, arg14)), v19);
        let v22 = Hedc59{
            hd5f7d : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v18),
            h668c7 : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v18),
            he3ea7 : arg5,
            h443d9 : arg6,
            hcf99a : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v18),
            he214c : v20,
            h7b14f : v21,
        };
        0x2::event::emit<Hedc59>(v22);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::ha4cf0<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, 0, v18, arg14);
    }

    fun h80b9d<T0>(arg0: 0x2::object::ID, arg1: u64) {
        if (arg1 > 0) {
            let v0 = Hc1af8{
                h668c7 : arg0,
                h3ec5e : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
                h0db5d : arg1,
            };
            0x2::event::emit<Hc1af8>(v0);
        };
    }

    public fun hd6531<T0, T1, T2>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarder_index<T2>(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg0));
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h2bdbf<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1, 0, arg6);
            let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg3, arg0, v1, arg4, true, arg5);
            let v3 = 0x2::balance::value<T2>(&v2);
            h80b9d<T2>(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v1), v3);
            if (v3 > 0) {
                0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T2>(arg1, arg2, 0x2::coin::from_balance<T2>(v2, arg6), arg6);
            } else {
                0x2::balance::destroy_zero<T2>(v2);
            };
        };
    }

    fun heed14(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg1
        } else {
            arg0
        }
    }

    // decompiled from Move bytecode v6
}

