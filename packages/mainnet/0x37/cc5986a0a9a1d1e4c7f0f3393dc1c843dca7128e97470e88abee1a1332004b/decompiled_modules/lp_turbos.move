module 0xbdeaa7074a8c1ce8d3f714659325edaa3e26908ae2d9ffd30c883af9cbd537ba::lp_turbos {
    struct TurbosWitness has drop {
        dummy_field: bool,
    }

    public fun compound<T0, T1, T2>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::compound_fee_pips(arg0, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg2) as u64));
        let (v1, v2, v3, v4) = zap_in_nft_int<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), 0x2::coin::into_balance<T1>(arg6), 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::compound_fee_source(), v0, arg9, arg10);
        assert!(v1 >= arg7 && v2 >= arg8, 1);
        let v5 = init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_compounded<TurbosWitness>(arg0, &v5, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg4), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg10), 0x2::coin::from_balance<T1>(v4, arg10))
    }

    fun init_witness() : TurbosWitness {
        TurbosWitness{dummy_field: false}
    }

    public fun rebalance<T0, T1, T2>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::TurbosPositionBurnNFT) {
        let v0 = 0x2::coin::value<T0>(&arg7) > 0 || 0x2::coin::value<T1>(&arg8) > 0;
        let (_, _, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg3, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg4));
        let (v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg2, arg3, &mut arg4, v3, 0, 0, 0x2::clock::timestamp_ms(arg11) + 1000, arg11, arg1, arg12);
        let v6 = v5;
        let v7 = v4;
        0x2::coin::join<T0>(&mut arg7, v7);
        0x2::coin::join<T1>(&mut arg8, v6);
        let v8 = 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::rebalance_fee_pips(arg0, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg2) as u64));
        let (v9, v10, v11, v12, v13) = zap_in_int<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg5), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg6), 0x2::coin::into_balance<T0>(arg7), 0x2::coin::into_balance<T1>(arg8), 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::rebalance_fee_source(), v8, arg11, arg12);
        let v14 = v13;
        assert!(v9 >= arg9 && v10 >= arg10, 1);
        let v15 = init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_rebalanced<TurbosWitness>(arg0, &v15, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&arg4), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v14), 0x2::coin::value<T0>(&v7), 0x2::coin::value<T1>(&v6), v9, v10, v0);
        (0x2::coin::from_balance<T0>(v11, arg12), 0x2::coin::from_balance<T1>(v12, arg12), v14, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::burn_position_nft_with_return_<T0, T1, T2>(arg2, arg3, arg4, arg1, arg12))
    }

    fun swap_to_optimal<T0, T1, T2>(arg0: &0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg5: &mut 0x2::balance::Balance<T0>, arg6: &mut 0x2::balance::Balance<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, _) = 0xbdeaa7074a8c1ce8d3f714659325edaa3e26908ae2d9ffd30c883af9cbd537ba::swap_math::optimal_swap<T0, T1, T2>(arg2, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(arg3), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(arg4), 0x2::balance::value<T0>(arg5), 0x2::balance::value<T1>(arg6));
        if (v0 == 0 && v1 == 0) {
            return
        };
        let v4 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg2);
        let (v5, v6) = if (v2) {
            let v7 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v7, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg5, v0), arg8));
            let (v8, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg2, v7, v0, 0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_min_tick(v4)) + 1, true, 0x2::tx_context::sender(arg8), 0x2::clock::timestamp_ms(arg7) + 1000, arg7, arg1, arg8);
            (v9, v8)
        } else {
            let v10 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v10, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg6, v0), arg8));
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg2, v10, v0, 0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_max_tick(v4)) - 1, true, 0x2::tx_context::sender(arg8), 0x2::clock::timestamp_ms(arg7) + 1000, arg7, arg1, arg8)
        };
        let v11 = v6;
        let v12 = v5;
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::assert_price(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg2), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg2));
        let v13 = if (v2) {
            0x2::coin::value<T1>(&v11)
        } else {
            0x2::coin::value<T0>(&v12)
        };
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::assert_output(arg0, v1, v13);
        0x2::balance::join<T0>(arg5, 0x2::coin::into_balance<T0>(v12));
        0x2::balance::join<T1>(arg6, 0x2::coin::into_balance<T1>(v11));
    }

    public fun zap_in<T0, T1, T2>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::zap_fee_pips(arg0, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg2) as u64));
        let (v1, v2, v3, v4) = zap_in_nft_int<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::into_balance<T0>(arg5), 0x2::coin::into_balance<T1>(arg6), 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::zap_in_fee_source(), v0, arg9, arg10);
        assert!(v1 >= arg7 && v2 >= arg8, 1);
        let v5 = init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_zapped_in<TurbosWitness>(arg0, &v5, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg4), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg10), 0x2::coin::from_balance<T1>(v4, arg10))
    }

    fun zap_in_int<T0, T1, T2>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg5: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT) {
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::collect_fees<T0>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), &mut arg6, arg8, arg9);
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::collect_fees<T1>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), &mut arg7, arg8, arg9);
        let v0 = &mut arg6;
        let v1 = &mut arg7;
        swap_to_optimal<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5, v0, v1, arg10, arg11);
        let v2 = 0x2::balance::value<T0>(&arg6);
        let v3 = 0x2::balance::value<T1>(&arg7);
        assert!(v2 > 0 || v3 > 0, 0);
        let v4 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v4, 0x2::coin::from_balance<T0>(arg6, arg11));
        let v5 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v5, 0x2::coin::from_balance<T1>(arg7, arg11));
        let (v6, v7, v8) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<T0, T1, T2>(arg2, arg3, v4, v5, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(arg4), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(arg4), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(arg5), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(arg5), v2, v3, 0, 0, 0x2::clock::timestamp_ms(arg10) + 1000, arg10, arg1, arg11);
        let v9 = v8;
        let v10 = v7;
        (v2 - 0x2::coin::value<T0>(&v10), v3 - 0x2::coin::value<T1>(&v9), 0x2::coin::into_balance<T0>(v10), 0x2::coin::into_balance<T1>(v9), v6)
    }

    public fun zap_in_new_nft<T0, T1, T2>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: u32, arg5: u32, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT) {
        let v0 = 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::zap_fee_pips(arg0, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg2) as u64));
        let (v1, v2, v3, v4, v5) = zap_in_int<T0, T1, T2>(arg0, arg1, arg2, arg3, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg4), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg5), 0x2::coin::into_balance<T0>(arg6), 0x2::coin::into_balance<T1>(arg7), 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::zap_in_fee_source(), v0, arg10, arg11);
        let v6 = v5;
        assert!(v1 >= arg8 && v2 >= arg9, 1);
        let v7 = init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_zapped_in<TurbosWitness>(arg0, &v7, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v6), v1, v2);
        (0x2::coin::from_balance<T0>(v3, arg11), 0x2::coin::from_balance<T1>(v4, arg11), v6)
    }

    fun zap_in_nft_int<T0, T1, T2>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::collect_fees<T0>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), &mut arg5, arg7, arg8);
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::collect_fees<T1>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), &mut arg6, arg7, arg8);
        let (v0, v1, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg3, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg4));
        let v3 = &mut arg5;
        let v4 = &mut arg6;
        swap_to_optimal<T0, T1, T2>(arg0, arg1, arg2, v0, v1, v3, v4, arg9, arg10);
        let v5 = 0x2::balance::value<T0>(&arg5);
        let v6 = 0x2::balance::value<T1>(&arg6);
        assert!(v5 > 0 || v6 > 0, 0);
        let v7 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v7, 0x2::coin::from_balance<T0>(arg5, arg10));
        let v8 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v8, 0x2::coin::from_balance<T1>(arg6, arg10));
        let (v9, v10) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::increase_liquidity_with_return_<T0, T1, T2>(arg2, arg3, v7, v8, arg4, v5, v6, 0, 0, 0x2::clock::timestamp_ms(arg9) + 1000, arg9, arg1, arg10);
        let v11 = v10;
        let v12 = v9;
        (v5 - 0x2::coin::value<T0>(&v12), v6 - 0x2::coin::value<T1>(&v11), 0x2::coin::into_balance<T0>(v12), 0x2::coin::into_balance<T1>(v11))
    }

    public fun zap_out<T0, T1, T2>(arg0: &mut 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::Registry, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::into_balance<T2>(arg3);
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::collect_fees<T2>(arg0, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), &mut v0, 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::constants::zap_out_fee_source(), 0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::registry::zap_fee_pips(arg0, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg1) as u64)));
        assert!(0x2::balance::value<T2>(&v0) >= arg4, 1);
        let v1 = init_witness();
        0xf86be58c3d946cff2bd8b081ea084edeae9ee5143c7a130913c0333eaa53c02f::events::emit_zapped_out<TurbosWitness>(arg0, &v1, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg1), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg2), 0x1::type_name::get<T2>(), 0x2::balance::value<T2>(&v0));
        0x2::coin::from_balance<T2>(v0, arg5)
    }

    // decompiled from Move bytecode v6
}

