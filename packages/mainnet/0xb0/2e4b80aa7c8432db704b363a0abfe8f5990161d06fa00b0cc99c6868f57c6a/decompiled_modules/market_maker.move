module 0xb02e4b80aa7c8432db704b363a0abfe8f5990161d06fa00b0cc99c6868f57c6a::market_maker {
    struct RebalanceMinThresholdMet has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        amount_out: u64,
        min_base_threshold: u64,
        base_liquidity: u64,
    }

    struct RebalanceEmptyQuoteLiquidity has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        amount_out: u64,
        min_base_threshold: u64,
        base_liquidity: u64,
    }

    struct RebalanceMinQuoteOutNotMet has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        amount_out: u64,
        min_base_threshold: u64,
        base_liquidity: u64,
    }

    struct RebalanceWithdrawShares has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sender: address,
        receiver: 0x1::option::Option<address>,
        amount_out: u64,
        max_base_threshold: u64,
        base_liquidity: u64,
    }

    struct RebalanceWithdrawSharesMaxThresholdMet has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sender: address,
        receiver: 0x1::option::Option<address>,
        amount_out: u64,
        max_base_threshold: u64,
        base_liquidity: u64,
    }

    struct RebalanceWithdrawSharesZeroWithdrawableBaseByLp has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sender: address,
        receiver: 0x1::option::Option<address>,
        amount_out: u64,
        max_base_threshold: u64,
        base_liquidity: u64,
    }

    struct RebalanceWithdrawSharesEmptyBaseLiquidity has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sender: address,
        receiver: 0x1::option::Option<address>,
        amount_out: u64,
        max_base_threshold: u64,
        base_liquidity: u64,
    }

    fun internal_rebalance_swap_sell<T0, T1>(arg0: 0x2::object::ID, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = if (0x2::balance::value<T0>(&arg5) > arg6) {
            0x2::balance::split<T0>(&mut arg5, 0x2::balance::value<T0>(&arg5) - arg6)
        } else {
            0x2::balance::zero<T0>()
        };
        let v1 = v0;
        let v2 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap_reverse<T0, T1>(arg1, arg2, arg8, arg4);
        let (v3, _, _, _, _, _, v9, v10, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v2);
        let v12 = v3 + v9 + v10;
        if (0x2::balance::value<T0>(&arg5) > v12) {
            0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg5, 0x2::balance::value<T0>(&arg5) - v12));
        };
        let (v13, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T1, T0>(arg2, arg8);
        let v15 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128(((arg7 - arg3) as u128), 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_precision(), v13);
        let v16 = if (v15 > (arg4 as u128)) {
            v12
        } else {
            let v17 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap_reverse<T0, T1>(arg1, arg2, arg8, (v15 as u64));
            let (v18, _, _, _, _, _, v24, v25, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v17);
            v18 + v24 + v25
        };
        if (0x2::balance::value<T0>(&arg5) > v16) {
            0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg5, 0x2::balance::value<T0>(&arg5) - v16));
        };
        let (_, _, _, _, _, _, v33, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::quote_asset_info_inner(0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_asset_info<T0, T1>(arg1));
        let v35 = 0x2::balance::value<T0>(&arg5);
        let v36 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap<T0, T1>(arg1, arg2, arg8, v35);
        let (_, v38, _, _, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v36);
        if (v38 < v33) {
            let v48 = RebalanceMinQuoteOutNotMet{
                pool_id            : arg0,
                sender             : 0x2::tx_context::sender(arg9),
                amount_out         : v35,
                min_base_threshold : arg7,
                base_liquidity     : arg3,
            };
            0x2::event::emit<RebalanceMinQuoteOutNotMet>(v48);
            0x2::balance::join<T0>(&mut arg5, v1);
            (arg5, 0x2::balance::zero<T1>())
        } else {
            let (v49, v50) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg1, arg2, arg8, arg5, 0x1::option::none<u64>(), arg9);
            let v51 = v49;
            0x2::balance::join<T0>(&mut v51, v1);
            (v51, v50)
        }
    }

    public fun rebalance_swap_sell<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_info<T0>(arg0);
        let (v2, v3, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_info_inner(&v1);
        let v9 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg0);
        let (v10, v11) = if (v3 >= arg4) {
            let v12 = RebalanceMinThresholdMet{
                pool_id            : v2,
                sender             : 0x2::tx_context::sender(arg7),
                amount_out         : 0x2::balance::value<T0>(&v0),
                min_base_threshold : arg4,
                base_liquidity     : v3,
            };
            0x2::event::emit<RebalanceMinThresholdMet>(v12);
            (v0, 0x2::balance::zero<T1>())
        } else if (v9 == 0) {
            let v13 = RebalanceEmptyQuoteLiquidity{
                pool_id            : v2,
                sender             : 0x2::tx_context::sender(arg7),
                amount_out         : 0x2::balance::value<T0>(&v0),
                min_base_threshold : arg4,
                base_liquidity     : v3,
            };
            0x2::event::emit<RebalanceEmptyQuoteLiquidity>(v13);
            (v0, 0x2::balance::zero<T1>())
        } else {
            internal_rebalance_swap_sell<T0, T1>(v2, arg0, arg1, v3, v9, v0, arg3, arg4, arg6, arg7)
        };
        let v14 = 0x2::tx_context::sender(arg7);
        if (0x1::option::is_some<address>(&arg5)) {
            v14 = *0x1::option::borrow<address>(&arg5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg7), v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v11, arg7), v14);
    }

    public fun rebalance_withdraw_shares<T0>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LPPosition<T0>, arg2: u64, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_info<T0>(arg0);
        let (v2, v3, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_info_inner(&v1);
        if (v3 == 0) {
            let v9 = RebalanceWithdrawSharesEmptyBaseLiquidity{
                pool_id            : v2,
                position_id        : 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LPPosition<T0>>(arg1),
                sender             : v0,
                receiver           : arg3,
                amount_out         : 0,
                max_base_threshold : arg2,
                base_liquidity     : v3,
            };
            0x2::event::emit<RebalanceWithdrawSharesEmptyBaseLiquidity>(v9);
            return
        };
        if (v3 <= arg2) {
            let v10 = RebalanceWithdrawSharesMaxThresholdMet{
                pool_id            : v2,
                position_id        : 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LPPosition<T0>>(arg1),
                sender             : v0,
                receiver           : arg3,
                amount_out         : 0,
                max_base_threshold : arg2,
                base_liquidity     : v3,
            };
            0x2::event::emit<RebalanceWithdrawSharesMaxThresholdMet>(v10);
            return
        };
        let v11 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_withdrawable_base_by_lp<T0>(arg0, arg1);
        let (v12, _, v14) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::withdrawable_base_by_lp_inner(&v11);
        if (v12 == 0) {
            let v15 = RebalanceWithdrawSharesZeroWithdrawableBaseByLp{
                pool_id            : v2,
                position_id        : 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LPPosition<T0>>(arg1),
                sender             : v0,
                receiver           : arg3,
                amount_out         : 0,
                max_base_threshold : arg2,
                base_liquidity     : v3,
            };
            0x2::event::emit<RebalanceWithdrawSharesZeroWithdrawableBaseByLp>(v15);
            return
        };
        let v16 = if (0x1::option::is_some<address>(&arg3)) {
            *0x1::option::borrow<address>(&arg3)
        } else {
            v0
        };
        let v17 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_initial_lp_multiplier();
        let v18 = if (v17 == 0) {
            0
        } else {
            0x1::u64::min(v3 - arg2, 0x1::u64::min(18446744073709551615 / v17, v14 / v17)) * v17
        };
        let v19 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::withdraw_shares_balance<T0>(arg0, arg1, v18, v16, arg4);
        let v20 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_info<T0>(arg0);
        let (_, v22, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_info_inner(&v20);
        let v28 = RebalanceWithdrawShares{
            pool_id            : v2,
            position_id        : 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LPPosition<T0>>(arg1),
            sender             : v0,
            receiver           : arg3,
            amount_out         : 0x2::balance::value<T0>(&v19),
            max_base_threshold : arg2,
            base_liquidity     : v22,
        };
        0x2::event::emit<RebalanceWithdrawShares>(v28);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v19, arg4), v16);
    }

    // decompiled from Move bytecode v6
}

