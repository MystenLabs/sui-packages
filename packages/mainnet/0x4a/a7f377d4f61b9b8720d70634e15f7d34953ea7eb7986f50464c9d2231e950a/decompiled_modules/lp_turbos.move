module 0x4aa7f377d4f61b9b8720d70634e15f7d34953ea7eb7986f50464c9d2231e950a::lp_turbos {
    struct TurbosWitness has drop {
        dummy_field: bool,
    }

    public(friend) fun mint_proxy_cap(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry) : 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::ProxyCap {
        let v0 = TurbosWitness{dummy_field: false};
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::mint_proxy_cap<TurbosWitness>(arg0, v0)
    }

    public fun compound<T0, T1, T2>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: vector<0x1::string::String>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::tx_context::sender(arg12);
        compound_int<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v0, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::compound_source(), arg11, arg12)
    }

    public(friend) fun compound_int<T0, T1, T2>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: vector<0x1::string::String>, arg11: address, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg3);
        let (v1, v2, v3, v4) = zap_in_nft_int<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<T0>(arg6), 0x2::coin::into_balance<T1>(arg7), arg12, arg11, arg13, arg14);
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::assert_price(arg0, v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg3));
        assert!(v1 >= arg8 && v2 >= arg9, 1);
        let v5 = mint_proxy_cap(arg0);
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::events::emit_compounded(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg5), v1, v2, arg10, &v5);
        (0x2::coin::from_balance<T0>(v3, arg14), 0x2::coin::from_balance<T1>(v4, arg14))
    }

    public fun rebalance<T0, T1, T2>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg6: 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::RebalanceReceipt, arg7: u32, arg8: u32, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T1>, arg11: u64, arg12: u64, arg13: vector<0x1::string::String>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT) {
        let v0 = 0x2::tx_context::sender(arg15);
        rebalance_int<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, v0, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::rebalance_source(), arg14, arg15)
    }

    public(friend) fun rebalance_int<T0, T1, T2>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg6: 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::RebalanceReceipt, arg7: u32, arg8: u32, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T1>, arg11: u64, arg12: u64, arg13: vector<0x1::string::String>, arg14: address, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT) {
        let (_, _, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg4, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg5));
        assert!(v2 == 0, 3);
        let (v3, v4, v5, v6, v7) = zap_in_int<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg7), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg8), 0x2::coin::into_balance<T0>(arg9), 0x2::coin::into_balance<T1>(arg10), arg15, arg14, arg16, arg17);
        let v8 = v7;
        assert!(v3 >= arg11 && v4 >= arg12, 1);
        let v9 = mint_proxy_cap(arg0);
        let (v10, v11, v12, v13, v14) = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::destroy_rebalance_receipt(arg6, &v9);
        assert!(0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::math::get_liquidity_in_y(v3, v4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg3)) >= v14, 1);
        assert!(v10 == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg5), 4);
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::assert_price(arg0, v13, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg3));
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::events::emit_rebalanced(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), v10, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v8), v11, v12, v3, v4, v13, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg3), arg13, &v9);
        (0x2::coin::from_balance<T0>(v5, arg17), 0x2::coin::from_balance<T1>(v6, arg17), v8)
    }

    public fun start_rebalance<T0, T1, T2>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::RebalanceReceipt, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = mint_proxy_cap(arg0);
        let (_, _, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg3, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg4));
        let (v4, v5) = if (v3 > 0) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg2, arg3, arg4, v3, 0, 0, 0x2::clock::timestamp_ms(arg6) + 1000, arg6, arg1, arg7)
        } else {
            (0x2::coin::zero<T0>(arg7), 0x2::coin::zero<T1>(arg7))
        };
        let v6 = v5;
        let v7 = v4;
        (0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::state::new_rebalance_receipt(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg4), 0x2::coin::value<T0>(&v7), 0x2::coin::value<T1>(&v6), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg2), arg5, &v0), v7, v6)
    }

    fun swap_to_optimal<T0, T1, T2>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg5: &mut 0x2::balance::Balance<T0>, arg6: &mut 0x2::balance::Balance<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, _) = 0x4aa7f377d4f61b9b8720d70634e15f7d34953ea7eb7986f50464c9d2231e950a::swap_math::optimal_swap<T0, T1, T2>(arg2, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(arg3), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(arg4), 0x2::balance::value<T0>(arg5), 0x2::balance::value<T1>(arg6));
        if (v0 == 0 && v1 == 0) {
            return
        };
        let v4 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg2);
        let (v5, v6) = if (v2) {
            let (v7, v8) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_a_b_with_return_<T0, T1, T2>(arg2, 0x1::vector::singleton<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg5, v0), arg8)), v0, 0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_min_tick(v4)) + 1, true, 0x2::tx_context::sender(arg8), 0x2::clock::timestamp_ms(arg7) + 1000, arg7, arg1, arg8);
            (v8, v7)
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a_with_return_<T0, T1, T2>(arg2, 0x1::vector::singleton<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg6, v0), arg8)), v0, 0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::get_max_tick(v4)) - 1, true, 0x2::tx_context::sender(arg8), 0x2::clock::timestamp_ms(arg7) + 1000, arg7, arg1, arg8)
        };
        let v9 = v6;
        let v10 = v5;
        let v11 = if (v2) {
            0x2::coin::value<T1>(&v9)
        } else {
            0x2::coin::value<T0>(&v10)
        };
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::assert_output(arg0, v1, v11);
        0x2::balance::join<T0>(arg5, 0x2::coin::into_balance<T0>(v10));
        0x2::balance::join<T1>(arg6, 0x2::coin::into_balance<T1>(v9));
    }

    public fun zap_in<T0, T1, T2>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg3);
        let v1 = 0x2::tx_context::sender(arg11);
        let (v2, v3, v4, v5) = zap_in_nft_int<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::coin::into_balance<T0>(arg6), 0x2::coin::into_balance<T1>(arg7), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::zap_in_source(), v1, arg10, arg11);
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::assert_price(arg0, v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg3));
        assert!(v2 >= arg8 && v3 >= arg9, 1);
        let v6 = mint_proxy_cap(arg0);
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::events::emit_zapped_in(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg5), v2, v3, &v6);
        (0x2::coin::from_balance<T0>(v4, arg11), 0x2::coin::from_balance<T1>(v5, arg11))
    }

    fun zap_in_int<T0, T1, T2>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg6: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg7: 0x2::balance::Balance<T0>, arg8: 0x2::balance::Balance<T1>, arg9: u64, arg10: address, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT) {
        let v0 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::fee_pips(arg0, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg3) as u64), arg9);
        let v1 = &mut arg7;
        let v2 = &mut arg8;
        swap_to_optimal<T0, T1, T2>(arg0, arg2, arg3, arg5, arg6, v1, v2, arg11, arg12);
        let v3 = 0x2::balance::value<T0>(&arg7);
        let v4 = 0x2::balance::value<T1>(&arg8);
        assert!(v3 > 0 || v4 > 0, 0);
        let (v5, v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<T0, T1, T2>(arg3, arg4, 0x1::vector::singleton<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg7, arg12)), 0x1::vector::singleton<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(arg8, arg12)), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(arg5), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(arg5), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(arg6), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(arg6), v3, v4, 0, 0, 0x2::clock::timestamp_ms(arg11) + 1000, arg11, arg2, arg12);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::collect_fees<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, T0>(arg1, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v10), arg10, arg9, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::utils::split_balance_by_pips<T0>(&mut arg7, v0));
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::collect_fees<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, T1>(arg1, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v10), arg10, arg9, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::utils::split_balance_by_pips<T1>(&mut arg8, v0));
        (v3 - 0x2::coin::value<T0>(&v9), v4 - 0x2::coin::value<T1>(&v8), 0x2::coin::into_balance<T0>(v9), 0x2::coin::into_balance<T1>(v8), v10)
    }

    public fun zap_in_new_nft<T0, T1, T2>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg3);
        let v1 = 0x2::tx_context::sender(arg12);
        let (v2, v3, v4, v5, v6) = zap_in_int<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg5), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg6), 0x2::coin::into_balance<T0>(arg7), 0x2::coin::into_balance<T1>(arg8), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::zap_in_source(), v1, arg11, arg12);
        let v7 = v6;
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::assert_price(arg0, v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg3));
        assert!(v2 >= arg9 && v3 >= arg10, 1);
        let v8 = mint_proxy_cap(arg0);
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::events::emit_zapped_in(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v7), v2, v3, &v8);
        (0x2::coin::from_balance<T0>(v4, arg12), 0x2::coin::from_balance<T1>(v5, arg12), v7)
    }

    fun zap_in_nft_int<T0, T1, T2>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: u64, arg9: address, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::fee_pips(arg0, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg3) as u64), arg8);
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::collect_fees<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, T0>(arg1, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg5), arg9, arg8, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::utils::split_balance_by_pips<T0>(&mut arg6, v0));
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::collect_fees<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, T1>(arg1, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg5), arg9, arg8, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::utils::split_balance_by_pips<T1>(&mut arg7, v0));
        let (v1, v2, _) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg4, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg5));
        let v4 = &mut arg6;
        let v5 = &mut arg7;
        swap_to_optimal<T0, T1, T2>(arg0, arg2, arg3, v1, v2, v4, v5, arg10, arg11);
        let v6 = 0x2::balance::value<T0>(&arg6);
        let v7 = 0x2::balance::value<T1>(&arg7);
        assert!(v6 > 0 || v7 > 0, 0);
        let (v8, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::increase_liquidity_with_return_<T0, T1, T2>(arg3, arg4, 0x1::vector::singleton<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg6, arg11)), 0x1::vector::singleton<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(arg7, arg11)), arg5, v6, v7, 0, 0, 0x2::clock::timestamp_ms(arg10) + 1000, arg10, arg2, arg11);
        let v10 = v9;
        let v11 = v8;
        (v6 - 0x2::coin::value<T0>(&v11), v7 - 0x2::coin::value<T1>(&v10), 0x2::coin::into_balance<T0>(v11), 0x2::coin::into_balance<T1>(v10))
    }

    public fun zap_out<T0, T1, T2, T3>(arg0: &0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::Registry, arg1: &mut 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::Collector<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg4: 0x2::coin::Coin<T3>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::pool_id(arg3) == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), 2);
        let v0 = 0x2::coin::into_balance<T3>(arg4);
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::lp_registry::collect_fees<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, T3>(arg1, 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg3), 0x2::tx_context::sender(arg6), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::zap_out_source(), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::utils::split_balance_by_pips<T3>(&mut v0, 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::registry::fee_pips(arg0, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg2) as u64), 0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::constants::zap_out_source())));
        assert!(0x2::balance::value<T3>(&v0) >= arg5, 1);
        let v1 = mint_proxy_cap(arg0);
        0x26bf21a298d81e2018089f1e5812d7b6d944401f1f04a2da1728a972679a1678::events::emit_zapped_out(0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(arg3), 0x1::type_name::with_original_ids<T3>(), 0x2::balance::value<T3>(&v0), &v1);
        0x2::coin::from_balance<T3>(v0, arg6)
    }

    // decompiled from Move bytecode v6
}

