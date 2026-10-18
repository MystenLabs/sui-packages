module 0x6e4ee9629ddcfb56bef332e86dcbabaf7493c4374477832945eee9f74480d8dd::pmm {
    fun buy_out<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: u128, arg5: u64, arg6: u64) : u64 {
        if ((arg3 as u256) * 1000000000000000000 / (arg4 as u256) < 1000) {
            return 0
        };
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_buy_swap<T0, T1>(arg0, arg1, arg2, arg3);
        let (v1, _, _, _, _, _, _, v8, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v0);
        if (v1 < arg6 || (v1 as u128) + (v8 as u128) > (arg5 as u128)) {
            0
        } else {
            v1
        }
    }

    fun buy_quotes<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: &vector<u64>, arg4: u64) : vector<u64> {
        let v0 = 0x1::vector::length<u64>(arg3);
        let v1 = vector[];
        let v2 = if (v0 == 0 || !tradable<T0, T1>(arg0)) {
            0
        } else {
            live_price<T0, T1>(arg1, arg2)
        };
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        if (v2 > 0) {
            v3 = buy_room<T0, T1>(arg0, v2, arg4);
            let v6 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_info<T0>(arg0);
            let (_, v8, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_info_inner(&v6);
            v4 = v8;
            let v14 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_config<T0>(arg0);
            let (_, _, _, _, _, v20) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_config_inner(&v14);
            v5 = v20;
        };
        let v21 = 0;
        while (v21 < v0) {
            let v22 = *0x1::vector::borrow<u64>(arg3, v21);
            let v23 = if (v2 == 0) {
                true
            } else if (v22 == 0) {
                true
            } else {
                v22 > v3
            };
            let v24 = if (v23) {
                0
            } else {
                buy_out<T0, T1>(arg0, arg1, arg2, v22, v2, v4, v5)
            };
            0x1::vector::push_back<u64>(&mut v1, v24);
            v21 = v21 + 1;
        };
        v1
    }

    fun buy_room<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: u128, arg2: u64) : u64 {
        let (_, _, _, _, v4, v5, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::quote_asset_info_inner(0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_asset_info<T0, T1>(arg0));
        let v8 = v5;
        let v9 = v4;
        let v10 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_config<T0>(arg0);
        let (_, _, _, _, v15, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_config_inner(&v10);
        let v17 = if (0x1::option::is_some<u64>(&v9)) {
            *0x1::option::borrow<u64>(&v9)
        } else {
            v15
        };
        let v18 = (arg2 as u256) * (arg1 as u256) / 1000000000000000000 * (v17 as u256) / 10000;
        let v19 = v18;
        if (0x1::option::is_some<u64>(&v8) && (*0x1::option::borrow<u64>(&v8) as u256) < v18) {
            v19 = (*0x1::option::borrow<u64>(&v8) as u256);
        };
        let v20 = v19 - v19 * 50 / 10000;
        let v21 = (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg0) as u256);
        if (v20 <= v21) {
            0
        } else {
            let v23 = v20 - v21;
            if (v23 > 18446744073709551615) {
                18446744073709551615
            } else {
                (v23 as u64)
            }
        }
    }

    public fun live_price<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg1: &0x2::clock::Clock) : u128 {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::get_price<T0, T1>(arg0);
        let v1 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::price_response_pair_data(&v0);
        if (0x1::option::is_none<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::PriceData>(&v1)) {
            return 0
        };
        let v2 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::price_data_price<T0, T1>(0x1::option::borrow<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::PriceData>(&v1));
        if (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::is_expired<T0, T1>(&v2, arg1)) {
            0
        } else {
            0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::get_price<T0, T1>(&v2)
        }
    }

    public fun quote_buy<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u64) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::begin(arg0, 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1));
        0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::end(arg0, buy_quotes<T0, T1>(arg1, arg2, arg3, &v0, arg4));
    }

    public fun quote_sell<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::begin(arg0, 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1));
        0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::end(arg0, sell_quotes<T0, T1>(arg1, arg2, arg3, &v0));
    }

    fun sell_out<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: u128, arg5: u64, arg6: u64) : u64 {
        if (arg3 == 0 || (arg3 as u256) < 1000) {
            return 0
        };
        if ((arg3 as u256) * 1000000000000000000 / (arg4 as u256) > (arg5 as u256)) {
            return 0
        };
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap<T0, T1>(arg0, arg1, arg2, arg3);
        let (_, v2, _, _, _, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v0);
        if (v2 < arg6 || v2 == 0) {
            0
        } else {
            v2
        }
    }

    fun sell_quotes<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: &vector<u64>) : vector<u64> {
        let v0 = 0x1::vector::length<u64>(arg3);
        let v1 = vector[];
        let v2 = if (v0 == 0 || !tradable<T0, T1>(arg0)) {
            0
        } else {
            live_price<T1, T0>(arg1, arg2)
        };
        let (v3, v4) = if (v2 == 0) {
            (0, 0)
        } else {
            let (_, _, _, _, _, _, v11, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::quote_asset_info_inner(0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_asset_info<T0, T1>(arg0));
            (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg0), v11)
        };
        let v13 = 0;
        while (v13 < v0) {
            let v14 = if (v2 == 0) {
                0
            } else {
                sell_out<T0, T1>(arg0, arg1, arg2, *0x1::vector::borrow<u64>(arg3, v13), v2, v3, v4)
            };
            0x1::vector::push_back<u64>(&mut v1, v14);
            v13 = v13 + 1;
        };
        v1
    }

    public fun swap_buy<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg3) == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
            return 0x2::balance::zero<T0>()
        };
        let (v0, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg0, arg1, arg2, arg3, 0x1::option::none<u64>(), arg4);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    public fun swap_sell<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T1>()
        };
        let (v0, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg0, arg1, arg2, arg3, 0x1::option::none<u64>(), arg4);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    fun tradable<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>) : bool {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_info<T0>(arg0);
        let (_, _, _, _, _, _, v7) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_info_inner(&v0);
        let (_, _, _, _, _, _, _, v15) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::quote_asset_info_inner(0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_asset_info<T0, T1>(arg0));
        !v7 && v15
    }

    // decompiled from Move bytecode v7
}

