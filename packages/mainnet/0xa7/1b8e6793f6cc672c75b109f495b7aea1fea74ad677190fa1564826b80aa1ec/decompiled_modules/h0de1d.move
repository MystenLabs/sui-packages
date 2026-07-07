module 0xa71b8e6793f6cc672c75b109f495b7aea1fea74ad677190fa1564826b80aa1ec::h0de1d {
    struct H2a46e has copy, drop {
        h62ea5: 0x2::object::ID,
        h344c2: 0x2::object::ID,
        hab034: u32,
        h97ced: u32,
        h623f0: u128,
        hfb27a: u64,
        hef3f9: u64,
    }

    struct H79698 has copy, drop {
        h62ea5: 0x2::object::ID,
        h344c2: 0x2::object::ID,
        h623f0: u128,
        hbaccd: u64,
        h195b9: u64,
        hfc891: u64,
        hc3b43: u64,
    }

    struct H3b994 has copy, drop {
        h344c2: 0x2::object::ID,
        hc9071: 0x1::ascii::String,
        h0799e: u64,
    }

    struct H1a0f6 has copy, drop {
        hc37c6: u64,
    }

    fun h2f0f0<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg4) > arg13) {
            abort 13906834672559718403
        };
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h8d9ea(arg1, 3, arg14);
        let v0 = h7208e(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg2), arg9, arg11);
        let v1 = h7208e(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg2), arg10, arg12);
        let v2 = if (arg8) {
            v0
        } else {
            v1
        };
        let v3 = hf4a45(arg7, v2);
        let v4 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg5);
        let v5 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg6);
        let v6 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0);
        let v7 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v4);
        let v8 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v5);
        let v9 = if (v6 <= v7) {
            v7 + 1
        } else if (v6 >= v8) {
            v8 - 1
        } else {
            v6
        };
        let v10 = if (arg8) {
            v1
        } else {
            v0
        };
        let (v11, v12) = if (arg8) {
            let v13 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amount_y_for_liquidity(v7, v9, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amount_x(v9, v8, v3), true);
            if (v13 <= v10) {
                (v3, v13)
            } else {
                (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amount_x_for_liquidity(v9, v8, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amount_y(v7, v9, v10), true), v10)
            }
        } else {
            let v14 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amount_x_for_liquidity(v9, v8, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amount_y(v7, v9, v3), true);
            if (v14 <= v10) {
                (v14, v3)
            } else {
                (v10, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amount_y_for_liquidity(v7, v9, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amount_x(v9, v8, v10), true))
            }
        };
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amounts(v6, v7, v8, v11, v12) > 0, 13906835110646251521);
        assert!(v11 <= v0 && v12 <= v1, 13906835114941480965);
        let v15 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T0, T1>(arg0, v4, v5, arg3, arg14);
        let (v16, v17) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg0, &mut v15, 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T0>(arg1, arg2, v11, arg14), 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hf6525<T1>(arg1, arg2, v12, arg14), 0, 0, arg4, arg3, arg14);
        let v18 = v17;
        let v19 = v16;
        let v20 = H2a46e{
            h62ea5 : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::pool_id(&v15),
            h344c2 : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&v15),
            hab034 : arg5,
            h97ced : arg6,
            h623f0 : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(&v15),
            hfb27a : v11 - 0x2::coin::value<T0>(&v19),
            hef3f9 : v12 - 0x2::coin::value<T1>(&v18),
        };
        0x2::event::emit<H2a46e>(v20);
        if (0x2::coin::value<T0>(&v19) > 0) {
            0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T0>(arg1, arg2, v19, arg14);
        } else {
            0x2::coin::destroy_zero<T0>(v19);
        };
        if (0x2::coin::value<T1>(&v18) > 0) {
            0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T1>(arg1, arg2, v18, arg14);
        } else {
            0x2::coin::destroy_zero<T1>(v18);
        };
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::ha4cf0<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg1, 3, v15, arg14);
    }

    fun h3445e<T0>(arg0: 0x2::object::ID, arg1: u64) {
        if (arg1 > 0) {
            let v0 = H3b994{
                h344c2 : arg0,
                hc9071 : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
                h0799e : arg1,
            };
            0x2::event::emit<H3b994>(v0);
        };
    }

    fun h4b760<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h2cb40<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg1, 3, arg5);
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(&v0);
        let (v2, v3) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg0, &mut v0, v1, 0, 0, arg4, arg3, arg5);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<T0, T1>(arg0, &mut v0, arg4, arg3, arg5);
        let v8 = v7;
        let v9 = v6;
        let v10 = H79698{
            h62ea5 : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::pool_id(&v0),
            h344c2 : 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&v0),
            h623f0 : v1,
            hbaccd : 0x2::coin::value<T0>(&v5),
            h195b9 : 0x2::coin::value<T1>(&v4),
            hfc891 : 0x2::coin::value<T0>(&v9),
            hc3b43 : 0x2::coin::value<T1>(&v8),
        };
        0x2::event::emit<H79698>(v10);
        0x2::coin::join<T0>(&mut v5, v9);
        0x2::coin::join<T1>(&mut v4, v8);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(v0, arg3, arg5);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T0>(arg1, arg2, v5, arg5);
        0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T1>(arg1, arg2, v4, arg5);
    }

    public fun h6a222<T0, T1, T2>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h3fe3c<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg1, 3, arg5) && h98c0a<T0, T1, T2>(arg0)) {
            let v0 = 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hb9332<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg1, 3, arg5);
            let v1 = 0x2::object::id<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(v0);
            let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<T0, T1, T2>(arg0, v0, arg4, arg3, arg5);
            let v3 = 0x2::coin::value<T2>(&v2);
            h3445e<T2>(v1, v3);
            if (v3 > 0) {
                0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::hec8a2<T2>(arg1, arg2, v2, arg5);
            } else {
                0x2::coin::destroy_zero<T2>(v2);
            };
        };
    }

    fun h7208e(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        };
        hf4a45(v0, arg2)
    }

    public fun h84039<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg4) > arg13) {
            abort 13906835419884027907
        };
        if (0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h3fe3c<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg1, 3, arg14)) {
            h4b760<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg14);
        };
        h2f0f0<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
    }

    fun h98c0a<T0, T1, T2>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>) : bool {
        let v0 = 0;
        while (v0 < 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::reward_length<T0, T1>(arg0)) {
            if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::reward_coin_type<T0, T1>(arg0, v0) == 0x1::type_name::with_defining_ids<T2>()) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun hf4a45(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg1
        } else {
            arg0
        }
    }

    public fun hfa719<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::H0128d, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x99503febc627747fa177d5f14abe7f759e774da918221f6d27f2b6b7b3e8a8a4::hbdcc6::h3fe3c<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg1, 3, arg5)) {
            h4b760<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        } else {
            let v0 = H1a0f6{hc37c6: 3};
            0x2::event::emit<H1a0f6>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

