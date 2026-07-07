module 0x6b81c060c5390f443117779d1b552ef70c95b741d7bc4554daccc5ea13e67803::hcd246 {
    struct H2fdac has copy, drop {
        h0bd8c: 0x2::object::ID,
        h0a6d2: 0x2::object::ID,
        h9cace: u32,
        hdca13: u32,
        h493aa: u128,
        h25b1b: u64,
        h443ef: u64,
    }

    struct H3f99a has copy, drop {
        h0bd8c: 0x2::object::ID,
        h0a6d2: 0x2::object::ID,
        h493aa: u128,
        h55953: u64,
        h19ae2: u64,
        h93f94: u64,
        hd6778: u64,
    }

    struct H18900 has copy, drop {
        h0a6d2: 0x2::object::ID,
        h1d18c: 0x1::ascii::String,
        h09766: u64,
    }

    struct H77798 has copy, drop {
        h07543: u64,
    }

    fun h28e2d(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg1
        } else {
            arg0
        }
    }

    public fun h31cb1<T0, T1, T2>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h3fe3c<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1, 4, arg6)) {
            let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::rewarder_index<T2>(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::rewarder_manager<T0, T1>(arg0));
            0x1::option::is_some<u64>(&v1)
        } else {
            false
        };
        if (v0) {
            let v2 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h2bdbf<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1, 4, arg6);
            let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T2>(arg3, arg0, v2, arg4, true, arg5);
            let v4 = 0x2::balance::value<T2>(&v3);
            hf36cc<T2>(0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(v2), v4);
            if (v4 > 0) {
                0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T2>(arg1, arg2, 0x2::coin::from_balance<T2>(v3, arg6), arg6);
            } else {
                0x2::balance::destroy_zero<T2>(v3);
            };
        };
    }

    public fun h3c8cb<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h3fe3c<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1, 4, arg5)) {
            h801db<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        } else {
            let v0 = H77798{h07543: 4};
            0x2::event::emit<H77798>(v0);
        };
    }

    fun h801db<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h2cb40<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1, 4, arg5);
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&v0);
        let (v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::remove_liquidity<T0, T1>(arg3, arg0, &mut v0, v1, arg4);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_fee<T0, T1>(arg3, arg0, &v0, false);
        let v8 = v7;
        let v9 = v6;
        let v10 = H3f99a{
            h0bd8c : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::pool_id(&v0),
            h0a6d2 : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&v0),
            h493aa : v1,
            h55953 : 0x2::balance::value<T0>(&v5),
            h19ae2 : 0x2::balance::value<T1>(&v4),
            h93f94 : 0x2::balance::value<T0>(&v9),
            hd6778 : 0x2::balance::value<T1>(&v8),
        };
        0x2::event::emit<H3f99a>(v10);
        0x2::balance::join<T0>(&mut v5, v9);
        0x2::balance::join<T1>(&mut v4, v8);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::close_position<T0, T1>(arg3, arg0, v0);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(v5, arg5), arg5);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T1>(arg1, arg2, 0x2::coin::from_balance<T1>(v4, arg5), arg5);
    }

    fun h9fc08(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        };
        h28e2d(v0, arg2)
    }

    fun hcf0b8<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg4) > arg13) {
            abort 13906834590955208705
        };
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h8d9ea(arg1, 4, arg14);
        let v0 = h9fc08(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2), arg9, arg11);
        let v1 = h9fc08(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), arg10, arg12);
        let v2 = if (arg8) {
            v0
        } else {
            v1
        };
        let v3 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from_u32(arg5);
        let v4 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from_u32(arg6);
        let v5 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0);
        let v6 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0);
        let v7 = if (arg8) {
            v1
        } else {
            v0
        };
        let (_, v9, v10) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::get_liquidity_from_amount(v3, v4, v5, v6, h28e2d(arg7, v2), arg8);
        let v11 = v10;
        let v12 = v9;
        let v13 = arg8;
        if (v9 > v0 || v10 > v1) {
            let (_, v15, v16) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::get_liquidity_from_amount(v3, v4, v5, v6, v7, !arg8);
            v11 = v16;
            v12 = v15;
            v13 = !arg8;
        };
        assert!(v12 <= v0 && v11 <= v1, 13906834758459064323);
        let v17 = if (v13) {
            v12
        } else {
            v11
        };
        let v18 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::open_position<T0, T1>(arg3, arg0, arg5, arg6, arg14);
        let v19 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg3, arg0, &mut v18, v17, v13, arg4, arg14);
        let (v20, v21) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_pay_amount<T0, T1>(&v19);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_add_liquidity<T0, T1>(arg3, arg0, 0x2::coin::into_balance<T0>(0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T0>(arg1, arg2, v20, arg14)), 0x2::coin::into_balance<T1>(0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T1>(arg1, arg2, v21, arg14)), v19);
        let v22 = H2fdac{
            h0bd8c : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::pool_id(&v18),
            h0a6d2 : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&v18),
            h9cace : arg5,
            hdca13 : arg6,
            h493aa : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&v18),
            h25b1b : v20,
            h443ef : v21,
        };
        0x2::event::emit<H2fdac>(v22);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::ha4cf0<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1, 4, v18, arg14);
    }

    public fun he890f<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg4) > arg13) {
            abort 13906835054811676673
        };
        if (0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h3fe3c<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1, 4, arg14)) {
            h801db<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg14);
        };
        hcf0b8<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    fun hf36cc<T0>(arg0: 0x2::object::ID, arg1: u64) {
        if (arg1 > 0) {
            let v0 = H18900{
                h0a6d2 : arg0,
                h1d18c : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
                h09766 : arg1,
            };
            0x2::event::emit<H18900>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

