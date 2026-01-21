module 0x10c5129557f0d416bb1704974dbaa70991814248d8ab02dd0c2603b574b4dc41::market_maker {
    struct RebalanceMinThresholdMet<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        sender: address,
        amount_out: u64,
        min_base_threshold: u64,
        base_liquidity: u64,
    }

    fun internal_rebalance_swap_sell<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = if (0x2::balance::value<T0>(&arg3) > arg4) {
            0x2::balance::split<T0>(&mut arg3, 0x2::balance::value<T0>(&arg3) - arg4)
        } else {
            0x2::balance::zero<T0>()
        };
        let v1 = v0;
        let v2 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg0);
        let v3 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap_reverse<T0, T1>(arg0, arg1, arg6, v2);
        let (v4, _, _, _, _, _, v10, v11, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v3);
        let v13 = v4 + v10 + v11;
        if (0x2::balance::value<T0>(&arg3) > v13) {
            0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg3, 0x2::balance::value<T0>(&arg3) - v13));
        };
        let (v14, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T1, T0>(arg1, arg6);
        let v16 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128(((arg5 - arg2) as u128), 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_precision(), v14);
        let v17 = if (v16 > (v2 as u128)) {
            v13
        } else {
            let v18 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap_reverse<T0, T1>(arg0, arg1, arg6, (v16 as u64));
            let (v19, _, _, _, _, _, v25, v26, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v18);
            v19 + v25 + v26
        };
        if (0x2::balance::value<T0>(&arg3) > v17) {
            0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg3, 0x2::balance::value<T0>(&arg3) - v17));
        };
        let (v28, v29) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg0, arg1, arg6, arg3, 0x1::option::none<u64>(), arg7);
        let v30 = v28;
        0x2::balance::join<T0>(&mut v30, v1);
        (v30, v29)
    }

    public fun rebalance_swap_sell<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_info<T0>(arg0);
        let (v2, v3, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_info_inner(&v1);
        let (v9, v10) = if (v3 >= arg4) {
            let v11 = RebalanceMinThresholdMet<T0, T1>{
                pool_id            : v2,
                sender             : 0x2::tx_context::sender(arg7),
                amount_out         : 0x2::balance::value<T0>(&v0),
                min_base_threshold : arg4,
                base_liquidity     : v3,
            };
            0x2::event::emit<RebalanceMinThresholdMet<T0, T1>>(v11);
            (v0, 0x2::balance::zero<T1>())
        } else {
            internal_rebalance_swap_sell<T0, T1>(arg0, arg1, v3, v0, arg3, arg4, arg6, arg7)
        };
        let v12 = 0x2::tx_context::sender(arg7);
        if (0x1::option::is_some<address>(&arg5)) {
            v12 = *0x1::option::borrow<address>(&arg5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg7), v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v10, arg7), v12);
    }

    // decompiled from Move bytecode v6
}

