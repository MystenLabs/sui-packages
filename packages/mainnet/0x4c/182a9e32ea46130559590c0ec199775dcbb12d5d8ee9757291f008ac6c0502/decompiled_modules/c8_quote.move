module 0xc09f8802be006bb7300ec66a1af2394c4f66fcf1350d3b5c992ccb9cc0964998::c8_quote {
    struct BuyContext has drop {
        price: u256,
        ideal_low: u256,
        maximum_low: u256,
        limit_low: u256,
        balance: u64,
        reserve: u64,
        minimum: u64,
        swap_fee: u64,
        fee_base: u64,
        fee_max: u64,
    }

    public(friend) fun anchor_lower(arg0: u128, arg1: u64, arg2: u256) : u256 {
        ceil_div(ceil_div((arg0 as u256) * 10000, (arg1 as u256)) * 1000000000000000000, arg2)
    }

    public fun buy<T0, T1>(arg0: &BuyContext, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        if (!candidate_allowed(arg0, arg4)) {
            return 0
        };
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_buy_swap<T0, T1>(arg1, arg2, arg3, arg4);
        let (v1, _, _, _, _, _, _, v8, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v0);
        if (v1 < arg0.minimum || (v1 as u128) + (v8 as u128) > (arg0.reserve as u128)) {
            return 0
        };
        v1
    }

    public(friend) fun candidate_allowed(arg0: &BuyContext, arg1: u64) : bool {
        if (arg1 == 0) {
            return false
        };
        let v0 = (arg0.balance as u256) + (arg1 as u256);
        if (v0 > 18446744073709551615 || v0 > arg0.limit_low) {
            return false
        };
        let v1 = (arg1 as u256) * 1000000000000000000 / arg0.price;
        if (v1 < 2 || v1 > 18446744073709551615) {
            return false
        };
        let v2 = if (v0 <= arg0.ideal_low) {
            (arg0.fee_base as u256) * 1000
        } else if (arg0.maximum_low > 0) {
            (arg0.fee_base as u256) * 1000 + (arg0.fee_max as u256) * 1000 * v0 / arg0.maximum_low
        } else if (arg0.fee_max == 0) {
            (arg0.fee_base as u256) * 1000
        } else {
            return false
        };
        v2 + (arg0.swap_fee as u256) * 1000 <= 10000000
    }

    fun ceil_div(arg0: u256, arg1: u256) : u256 {
        let v0 = if (arg0 % arg1 == 0) {
            0
        } else {
            1
        };
        arg0 / arg1 + v0
    }

    public fun read_buy<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock) : BuyContext {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_config<T0>(arg0);
        let (v1, _, v3, _, v5, v6) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_config_inner(&v0);
        let v7 = v5;
        let v8 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_info<T0>(arg0);
        let (_, v10, _, _, _, _, v15) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_info_inner(&v8);
        let (v16, v17, v18, v19, v20, v21, _, v23) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::quote_asset_info_inner(0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_asset_info<T0, T1>(arg0));
        let v24 = v21;
        let v25 = v20;
        let v26 = if (!v15) {
            if (v23) {
                if (v1 > 0) {
                    if (v1 <= 5000) {
                        if (v3 < 10000) {
                            v16 > 0
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
        assert!(v26, 10);
        let v27 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap<T0, T1>(arg0, arg1, arg2, 2);
        let (_, v29, _, _, v32, _, _, _, v36) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v27);
        assert!(v29 == 0 && v36 > 0, 11);
        let v37 = 1000000000000000000 * 1000000000000000000 / (v36 as u256);
        assert!(v37 > 0, 11);
        let (v38, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T0, T1>(arg1, arg2);
        assert!(v38 > 0, 11);
        let v40 = anchor_lower(v32, v16, v37) * (v38 as u256) / 1000000000000000000;
        let v41 = 18446744073709551615;
        BuyContext{
            price       : (v38 as u256),
            ideal_low   : v40 * (v16 as u256) / 10000,
            maximum_low : v40 * (v17 as u256) / 10000,
            limit_low   : 0x1::u256::min(v40 * (*0x1::option::borrow_with_default<u64>(&v25, &v7) as u256) / 10000, (*0x1::option::borrow_with_default<u64>(&v24, &v41) as u256)),
            balance     : 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg0),
            reserve     : v10,
            minimum     : v6,
            swap_fee    : v1,
            fee_base    : v18,
            fee_max     : v19,
        }
    }

    // decompiled from Move bytecode v7
}

