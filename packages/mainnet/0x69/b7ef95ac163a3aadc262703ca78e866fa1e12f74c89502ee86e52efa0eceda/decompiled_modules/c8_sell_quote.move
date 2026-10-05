module 0xc09f8802be006bb7300ec66a1af2394c4f66fcf1350d3b5c992ccb9cc0964998::c8_sell_quote {
    struct SellContext has drop {
        price: u256,
        ideal: u256,
        maximum_low: u256,
        maximum_high: u256,
        balance: u64,
        minimum: u64,
        swap_fee: u64,
        fee_base: u64,
        fee_max: u64,
    }

    public(friend) fun candidate_allowed(arg0: &SellContext, arg1: u64) : bool {
        if (arg1 < 2) {
            return false
        };
        let v0 = (arg1 as u256) * 1000000000000000000 / arg0.price;
        if (v0 > 18446744073709551615) {
            return false
        };
        let v1 = (arg0.balance as u256) - 0x1::u256::min((arg0.balance as u256), v0);
        let v2 = (arg0.fee_base as u256) * 1000;
        let (v3, v4) = if (arg0.ideal == 0) {
            (0, 0)
        } else if (v1 <= arg0.ideal) {
            let v5 = v2 * v1 / arg0.ideal;
            (v5, v5)
        } else if (arg0.maximum_high == 0) {
            (v2, v2)
        } else {
            if (arg0.maximum_low == 0) {
                return false
            };
            let v6 = (arg0.fee_max as u256) * 1000 * v1;
            (v2 + v6 / arg0.maximum_high, v2 + v6 / arg0.maximum_low)
        };
        let v7 = (arg0.swap_fee as u256) * 1000;
        if (v4 + v7 > 10000000) {
            return false
        };
        ((arg1 as u256) - 0x1::u256::max(((arg1 as u256) * (v3 + v7) + 10000000 - 1) / 10000000, 2)) * 1000000000000000000 / arg0.price <= (arg0.balance as u256)
    }

    public fun read<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock) : SellContext {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_config<T0>(arg0);
        let (v1, _, v3, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_config_inner(&v0);
        let v7 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_info<T0>(arg0);
        let (_, _, _, _, _, _, v14) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_info_inner(&v7);
        let (v15, v16, v17, v18, _, _, v21, v22) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::quote_asset_info_inner(0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_asset_info<T0, T1>(arg0));
        let v23 = if (!v14) {
            if (v22) {
                if (v1 > 0) {
                    if (v1 <= 5000) {
                        if (v3 < 10000) {
                            v15 > 0
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v23, 10);
        let (v24, v25) = 0xc09f8802be006bb7300ec66a1af2394c4f66fcf1350d3b5c992ccb9cc0964998::c8_quote::reference<T0, T1>(arg0, arg1, arg2);
        SellContext{
            price        : (v25 as u256),
            ideal        : (v24 as u256),
            maximum_low  : ((v24 as u256) * 10000 + (v15 as u256) - 1) / (v15 as u256) * (v16 as u256) / 10000,
            maximum_high : (((v24 as u256) + 1) * 10000 - 1) / (v15 as u256) * (v16 as u256) / 10000,
            balance      : 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg0),
            minimum      : v21,
            swap_fee     : v1,
            fee_base     : v17,
            fee_max      : v18,
        }
    }

    public fun sell<T0, T1>(arg0: &SellContext, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        if (!candidate_allowed(arg0, arg4)) {
            return 0
        };
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap<T0, T1>(arg1, arg2, arg3, arg4);
        let (_, v2, _, _, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v0);
        if (v2 < arg0.minimum) {
            return 0
        };
        v2
    }

    // decompiled from Move bytecode v7
}

