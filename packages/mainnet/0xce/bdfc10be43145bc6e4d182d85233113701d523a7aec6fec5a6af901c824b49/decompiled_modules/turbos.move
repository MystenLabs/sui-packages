module 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::turbos {
    public fun collect<T0, T1, T2>(arg0: &mut 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::LiquidityManager, arg1: &0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::ManagerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: address, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x2::tx_context::TxContext) {
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::assert_admin(arg0, arg1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect<T0, T1, T2>(arg2, arg3, 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_turbos_position(arg0, arg4), arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun collect_reward<T0, T1, T2, T3>(arg0: &mut 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::LiquidityManager, arg1: &0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::ManagerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: 0x2::object::ID, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg6: u64, arg7: u64, arg8: address, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) {
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::assert_admin(arg0, arg1);
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_reward<T0, T1, T2, T3>(arg2, arg3, 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_turbos_position(arg0, arg4), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun increase_liquidity<T0, T1, T2>(arg0: &mut 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::LiquidityManager, arg1: &0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::ManagerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg12: &mut 0x2::tx_context::TxContext) {
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::assert_admin(arg0, arg1);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_balance_mut<T0>(arg0), arg5), arg12));
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_balance_mut<T1>(arg0), arg6), arg12));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::increase_liquidity<T0, T1, T2>(arg2, arg3, v0, v1, 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_turbos_position(arg0, arg4), arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public fun decrease_liquidity<T0, T1, T2>(arg0: &mut 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::LiquidityManager, arg1: &0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::ManagerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: 0x2::object::ID, arg5: u128, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x2::tx_context::TxContext) {
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::assert_admin(arg0, arg1);
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg2, arg3, 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_turbos_position(arg0, arg4), arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::balance::join<T0>(0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_balance_mut<T0>(arg0), 0x2::coin::into_balance<T0>(v0));
        0x2::balance::join<T1>(0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_balance_mut<T1>(arg0), 0x2::coin::into_balance<T1>(v1));
    }

    public fun mint_position<T0, T1, T2>(arg0: &mut 0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::LiquidityManager, arg1: &0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::ManagerCap, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg4: u32, arg5: bool, arg6: u32, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg15: &mut 0x2::tx_context::TxContext) {
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::assert_admin(arg0, arg1);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_balance_mut<T0>(arg0), arg8), arg15));
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v1, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_balance_mut<T1>(arg0), arg9), arg15));
        let (v2, v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<T0, T1, T2>(arg2, arg3, v0, v1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v5 = 0x1::vector::empty<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>();
        0x1::vector::push_back<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut v5, v2);
        0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::add_turbos_positions(arg0, arg1, v5, arg15);
        0x2::balance::join<T0>(0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_balance_mut<T0>(arg0), 0x2::coin::into_balance<T0>(v3));
        0x2::balance::join<T1>(0xbbda8e2341d0e829388d8dd227f801718aab143305442d663ca8fa014393325b::lp_manager::get_balance_mut<T1>(arg0), 0x2::coin::into_balance<T1>(v4));
    }

    // decompiled from Move bytecode v6
}

