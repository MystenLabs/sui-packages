module 0x2ccfba97fd0358b32847faff36ff178f55b8a7a61371481f415129eac1543072::market_maker {
    struct DepositAddress has copy, drop {
        address: address,
        memo: 0x1::option::Option<0x1::string::String>,
    }

    struct RebalanceSwapSellEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        status: u64,
        base_out: u64,
        quote_out: u64,
        min_base_threshold: u64,
        base_liquidity: u64,
        base_receiver: 0x1::option::Option<DepositAddress>,
        quote_receiver: 0x1::option::Option<DepositAddress>,
    }

    struct RebalanceWithdrawSharesEvent has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sender: address,
        receiver: 0x1::option::Option<DepositAddress>,
        status: u64,
        amount_out: u64,
        max_base_threshold: u64,
        base_liquidity: u64,
    }

    public fun build_deposit_address(arg0: 0x1::option::Option<address>, arg1: 0x1::option::Option<0x1::string::String>) : 0x1::option::Option<DepositAddress> {
        if (0x1::option::is_some<address>(&arg0)) {
            let v1 = DepositAddress{
                address : 0x1::option::destroy_some<address>(arg0),
                memo    : arg1,
            };
            0x1::option::some<DepositAddress>(v1)
        } else {
            0x1::option::none<DepositAddress>()
        }
    }

    fun internal_rebalance_swap_sell<T0, T1>(arg0: 0x2::object::ID, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: u64, arg7: u64, arg8: 0x1::option::Option<DepositAddress>, arg9: 0x1::option::Option<DepositAddress>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = if (0x2::balance::value<T0>(&arg5) > arg6) {
            0x2::balance::split<T0>(&mut arg5, 0x2::balance::value<T0>(&arg5) - arg6)
        } else {
            0x2::balance::zero<T0>()
        };
        let v1 = v0;
        let v2 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap_reverse<T0, T1>(arg1, arg2, arg10, arg4);
        let (v3, _, _, _, _, _, v9, v10, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v2);
        let v12 = v3 + v9 + v10;
        if (0x2::balance::value<T0>(&arg5) > v12) {
            0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg5, 0x2::balance::value<T0>(&arg5) - v12));
        };
        let (v13, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T1, T0>(arg2, arg10);
        let v15 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128(((arg7 - arg3) as u128), 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_precision(), v13);
        let v16 = if (v15 > (arg4 as u128)) {
            v12
        } else {
            let v17 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap_reverse<T0, T1>(arg1, arg2, arg10, (v15 as u64));
            let (v18, _, _, _, _, _, v24, v25, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v17);
            v18 + v24 + v25
        };
        if (0x2::balance::value<T0>(&arg5) > v16) {
            0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg5, 0x2::balance::value<T0>(&arg5) - v16));
        };
        let (_, _, _, _, _, _, v33, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::quote_asset_info_inner(0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_asset_info<T0, T1>(arg1));
        let v35 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap<T0, T1>(arg1, arg2, arg10, 0x2::balance::value<T0>(&arg5));
        let (_, v37, _, _, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v35);
        if (v37 < v33) {
            0x2::balance::join<T0>(&mut arg5, v1);
            let v47 = RebalanceSwapSellEvent{
                pool_id            : arg0,
                sender             : 0x2::tx_context::sender(arg11),
                status             : 6003,
                base_out           : 0x2::balance::value<T0>(&arg5),
                quote_out          : 0,
                min_base_threshold : arg7,
                base_liquidity     : arg3,
                base_receiver      : arg8,
                quote_receiver     : arg9,
            };
            0x2::event::emit<RebalanceSwapSellEvent>(v47);
            (arg5, 0x2::balance::zero<T1>())
        } else {
            let (v48, v49) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg1, arg2, arg10, arg5, 0x1::option::none<u64>(), arg11);
            let v50 = v49;
            let v51 = v48;
            0x2::balance::join<T0>(&mut v51, v1);
            let v52 = RebalanceSwapSellEvent{
                pool_id            : arg0,
                sender             : 0x2::tx_context::sender(arg11),
                status             : 6000,
                base_out           : 0x2::balance::value<T0>(&v51),
                quote_out          : 0x2::balance::value<T1>(&v50),
                min_base_threshold : arg7,
                base_liquidity     : arg3,
                base_receiver      : arg8,
                quote_receiver     : arg9,
            };
            0x2::event::emit<RebalanceSwapSellEvent>(v52);
            (v51, v50)
        }
    }

    public fun rebalance_swap_sell<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x1::option::Option<DepositAddress>, arg6: 0x1::option::Option<DepositAddress>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_info<T0>(arg0);
        let (v2, v3, _, _, _, _, v8) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_info_inner(&v1);
        if (v8) {
            let v9 = RebalanceSwapSellEvent{
                pool_id            : v2,
                sender             : 0x2::tx_context::sender(arg8),
                status             : 6200,
                base_out           : 0x2::balance::value<T0>(&v0),
                quote_out          : 0,
                min_base_threshold : arg4,
                base_liquidity     : v3,
                base_receiver      : arg5,
                quote_receiver     : arg6,
            };
            0x2::event::emit<RebalanceSwapSellEvent>(v9);
            let v10 = if (0x1::option::is_some<DepositAddress>(&arg5)) {
                0x1::option::borrow<DepositAddress>(&arg5).address
            } else {
                0x2::tx_context::sender(arg8)
            };
            if (0x2::balance::value<T0>(&v0) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg8), v10);
            } else {
                0x2::balance::destroy_zero<T0>(v0);
            };
            return
        };
        let v11 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg0);
        let (v12, v13) = if (0x2::balance::value<T0>(&v0) == 0) {
            let v14 = RebalanceSwapSellEvent{
                pool_id            : v2,
                sender             : 0x2::tx_context::sender(arg8),
                status             : 6004,
                base_out           : 0,
                quote_out          : 0,
                min_base_threshold : arg4,
                base_liquidity     : v3,
                base_receiver      : arg5,
                quote_receiver     : arg6,
            };
            0x2::event::emit<RebalanceSwapSellEvent>(v14);
            (0x2::balance::zero<T1>(), v0)
        } else {
            let (v15, v16) = if (arg3 == 0) {
                let v17 = RebalanceSwapSellEvent{
                    pool_id            : v2,
                    sender             : 0x2::tx_context::sender(arg8),
                    status             : 6005,
                    base_out           : 0x2::balance::value<T0>(&v0),
                    quote_out          : 0,
                    min_base_threshold : arg4,
                    base_liquidity     : v3,
                    base_receiver      : arg5,
                    quote_receiver     : arg6,
                };
                0x2::event::emit<RebalanceSwapSellEvent>(v17);
                (v0, 0x2::balance::zero<T1>())
            } else if (v3 >= arg4) {
                let v18 = RebalanceSwapSellEvent{
                    pool_id            : v2,
                    sender             : 0x2::tx_context::sender(arg8),
                    status             : 6001,
                    base_out           : 0x2::balance::value<T0>(&v0),
                    quote_out          : 0,
                    min_base_threshold : arg4,
                    base_liquidity     : v3,
                    base_receiver      : arg5,
                    quote_receiver     : arg6,
                };
                0x2::event::emit<RebalanceSwapSellEvent>(v18);
                (v0, 0x2::balance::zero<T1>())
            } else if (v11 == 0) {
                let v19 = RebalanceSwapSellEvent{
                    pool_id            : v2,
                    sender             : 0x2::tx_context::sender(arg8),
                    status             : 6002,
                    base_out           : 0x2::balance::value<T0>(&v0),
                    quote_out          : 0,
                    min_base_threshold : arg4,
                    base_liquidity     : v3,
                    base_receiver      : arg5,
                    quote_receiver     : arg6,
                };
                0x2::event::emit<RebalanceSwapSellEvent>(v19);
                (v0, 0x2::balance::zero<T1>())
            } else {
                internal_rebalance_swap_sell<T0, T1>(v2, arg0, arg1, v3, v11, v0, arg3, arg4, arg5, arg6, arg7, arg8)
            };
            (v16, v15)
        };
        let v20 = v12;
        let v21 = v13;
        let v22 = if (0x1::option::is_some<DepositAddress>(&arg5)) {
            0x1::option::borrow<DepositAddress>(&arg5).address
        } else {
            0x2::tx_context::sender(arg8)
        };
        let v23 = if (0x1::option::is_some<DepositAddress>(&arg6)) {
            0x1::option::borrow<DepositAddress>(&arg6).address
        } else {
            0x2::tx_context::sender(arg8)
        };
        if (0x2::balance::value<T0>(&v21) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v21, arg8), v22);
        } else {
            0x2::balance::destroy_zero<T0>(v21);
        };
        if (0x2::balance::value<T1>(&v20) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v20, arg8), v23);
        } else {
            0x2::balance::destroy_zero<T1>(v20);
        };
    }

    public fun rebalance_withdraw_shares<T0>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LPPosition<T0>, arg2: u64, arg3: 0x1::option::Option<DepositAddress>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_info<T0>(arg0);
        let (v2, v3, _, _, _, _, v8) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_info_inner(&v1);
        if (v8) {
            let v9 = RebalanceWithdrawSharesEvent{
                pool_id            : v2,
                position_id        : 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LPPosition<T0>>(arg1),
                sender             : v0,
                receiver           : arg3,
                status             : 6200,
                amount_out         : 0,
                max_base_threshold : arg2,
                base_liquidity     : v3,
            };
            0x2::event::emit<RebalanceWithdrawSharesEvent>(v9);
            return
        };
        if (v3 == 0) {
            let v10 = RebalanceWithdrawSharesEvent{
                pool_id            : v2,
                position_id        : 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LPPosition<T0>>(arg1),
                sender             : v0,
                receiver           : arg3,
                status             : 6102,
                amount_out         : 0,
                max_base_threshold : arg2,
                base_liquidity     : v3,
            };
            0x2::event::emit<RebalanceWithdrawSharesEvent>(v10);
            return
        };
        if (v3 <= arg2) {
            let v11 = RebalanceWithdrawSharesEvent{
                pool_id            : v2,
                position_id        : 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LPPosition<T0>>(arg1),
                sender             : v0,
                receiver           : arg3,
                status             : 6101,
                amount_out         : 0,
                max_base_threshold : arg2,
                base_liquidity     : v3,
            };
            0x2::event::emit<RebalanceWithdrawSharesEvent>(v11);
            return
        };
        let v12 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_withdrawable_base_by_lp<T0>(arg0, arg1);
        let (v13, _, v15) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::withdrawable_base_by_lp_inner(&v12);
        if (v13 == 0) {
            let v16 = RebalanceWithdrawSharesEvent{
                pool_id            : v2,
                position_id        : 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LPPosition<T0>>(arg1),
                sender             : v0,
                receiver           : arg3,
                status             : 6103,
                amount_out         : 0,
                max_base_threshold : arg2,
                base_liquidity     : v3,
            };
            0x2::event::emit<RebalanceWithdrawSharesEvent>(v16);
            return
        };
        let v17 = if (0x1::option::is_some<DepositAddress>(&arg3)) {
            0x1::option::borrow<DepositAddress>(&arg3).address
        } else {
            v0
        };
        let v18 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_initial_lp_multiplier();
        let v19 = if (v18 == 0) {
            0
        } else {
            0x1::u64::min(v3 - arg2, 0x1::u64::min(18446744073709551615 / v18, v15 / v18)) * v18
        };
        if (v19 == 0) {
            let v20 = RebalanceWithdrawSharesEvent{
                pool_id            : v2,
                position_id        : 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LPPosition<T0>>(arg1),
                sender             : v0,
                receiver           : arg3,
                status             : 6103,
                amount_out         : 0,
                max_base_threshold : arg2,
                base_liquidity     : v3,
            };
            0x2::event::emit<RebalanceWithdrawSharesEvent>(v20);
            return
        };
        let v21 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::withdraw_shares_balance<T0>(arg0, arg1, v19, v17, arg4);
        let v22 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_info<T0>(arg0);
        let (_, v24, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_info_inner(&v22);
        let v30 = RebalanceWithdrawSharesEvent{
            pool_id            : v2,
            position_id        : 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LPPosition<T0>>(arg1),
            sender             : v0,
            receiver           : arg3,
            status             : 6100,
            amount_out         : 0x2::balance::value<T0>(&v21),
            max_base_threshold : arg2,
            base_liquidity     : v24,
        };
        0x2::event::emit<RebalanceWithdrawSharesEvent>(v30);
        if (0x2::balance::value<T0>(&v21) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v21, arg4), v17);
        } else {
            0x2::balance::destroy_zero<T0>(v21);
        };
    }

    // decompiled from Move bytecode v6
}

