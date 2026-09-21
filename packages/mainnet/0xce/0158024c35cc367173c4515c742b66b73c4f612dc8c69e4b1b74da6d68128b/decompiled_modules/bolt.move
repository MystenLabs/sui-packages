module 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::bolt {
    fun cap_units(arg0: u64, arg1: u128, arg2: u128) : u64 {
        let v0 = (arg0 as u256) * 9950 * (arg1 as u256) / 10000 * (arg2 as u256);
        if (v0 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (v0 as u64)
        }
    }

    fun capped_amount(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun check<T0, T1>(arg0: &mut 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::Probe, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: bool, arg3: bool, arg4: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg5: &0x2::clock::Clock) {
        if (!0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::checking(arg0)) {
            return
        };
        let v0 = capped_amount(0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::check_amount(arg0), input_cap<T0, T1>(arg1, arg4, arg2, arg5));
        0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::check_step(arg0, v0, quote<T0, T1>(arg1, arg4, arg2, v0, arg5), arg3);
    }

    fun finish_swap<T0, T1>(arg0: 0x2::balance::Balance<T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg2, arg1);
        (0x2::coin::from_balance<T1>(arg0, arg3), 0x2::coin::from_balance<T0>(arg2, arg3))
    }

    public fun fold_live<T0, T1>(arg0: &mut 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::Probe, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: bool, arg3: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg4: &0x2::clock::Clock) {
        let v0 = 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::reference_input(arg0);
        if (v0 == 0) {
            0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::fold_closed(arg0);
            return
        };
        let v1 = capped_amount(v0, input_cap<T0, T1>(arg1, arg3, arg2, arg4));
        fold_quote(arg0, v1, quote<T0, T1>(arg1, arg3, arg2, v1, arg4));
    }

    fun fold_quote(arg0: &mut 0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::Probe, arg1: u64, arg2: u64) {
        if (arg1 == 0 || arg2 == 0) {
            0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::fold_closed(arg0);
            return
        };
        0xce0158024c35cc367173c4515c742b66b73c4f612dc8c69e4b1b74da6d68128b::probe::fold_to(arg0, (arg2 as u256), 0, (arg1 as u256), (arg1 as u256));
    }

    fun input_cap<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: bool, arg3: &0x2::clock::Clock) : u64 {
        let (v0, v1) = if (arg2) {
            let (v2, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T1, T0>(arg1, arg3);
            (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg0), v2)
        } else {
            let (v4, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_base_liquidity_inner<T0>(arg0);
            let (v6, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T0, T1>(arg1, arg3);
            (v4, v6)
        };
        cap_units(v0, v1, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_precision())
    }

    public fun quote<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = if (arg2) {
            0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap<T0, T1>(arg0, arg1, arg4, arg3)
        } else {
            0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_buy_swap<T0, T1>(arg0, arg1, arg4, arg3)
        };
        let v1 = v0;
        let (v2, v3, _, _, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v1);
        if (arg2) {
            v3
        } else {
            v2
        }
    }

    fun split_over_cap<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(arg0);
        if (v0 > arg1) {
            0x2::balance::split<T0>(arg0, v0 - arg1)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg2) == 0) {
            return (0x2::coin::zero<T1>(arg4), arg2)
        };
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = &mut v0;
        if (0x2::balance::value<T0>(&v0) == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return (0x2::coin::zero<T1>(arg4), 0x2::coin::from_balance<T0>(split_over_cap<T0>(v1, input_cap<T0, T1>(arg0, arg1, true, arg3)), arg4))
        };
        let (v2, v3) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg0, arg1, arg3, v0, 0x1::option::none<u64>(), arg4);
        finish_swap<T0, T1>(v3, v2, split_over_cap<T0>(v1, input_cap<T0, T1>(arg0, arg1, true, arg3)), arg4)
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (0x2::coin::value<T1>(&arg2) == 0) {
            return (0x2::coin::zero<T0>(arg4), arg2)
        };
        let v0 = 0x2::coin::into_balance<T1>(arg2);
        let v1 = &mut v0;
        if (0x2::balance::value<T1>(&v0) == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return (0x2::coin::zero<T0>(arg4), 0x2::coin::from_balance<T1>(split_over_cap<T1>(v1, input_cap<T0, T1>(arg0, arg1, false, arg3)), arg4))
        };
        let (v2, v3) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg0, arg1, arg3, v0, 0x1::option::none<u64>(), arg4);
        finish_swap<T1, T0>(v2, v3, split_over_cap<T1>(v1, input_cap<T0, T1>(arg0, arg1, false, arg3)), arg4)
    }

    // decompiled from Move bytecode v7
}

