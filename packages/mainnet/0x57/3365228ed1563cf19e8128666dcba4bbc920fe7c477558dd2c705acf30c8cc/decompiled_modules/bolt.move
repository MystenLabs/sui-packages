module 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::bolt {
    fun available<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>) : bool {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_info<T0>(arg0);
        let (_, _, _, _, _, _, v7) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_info_inner(&v0);
        let (_, _, _, _, _, _, _, v15) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::quote_asset_info_inner(0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_asset_info<T0, T1>(arg0));
        !v7 && v15
    }

    fun live<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::get_price<T0, T1>(arg0);
        let v1 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::price_response_pair_data(&v0);
        if (0x1::option::is_none<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::PriceData>(&v1)) {
            return false
        };
        let v2 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::price_data_price<T0, T1>(0x1::option::borrow<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::PriceData>(&v1));
        0x2::clock::timestamp_ms(arg1) < 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::get_expiry<T0, T1>(&v2) && 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::get_price<T0, T1>(&v2) > 0
    }

    fun output<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = if (arg2) {
            let (v1, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T0, T1>(arg1, arg4);
            v1
        } else {
            let (v3, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T1, T0>(arg1, arg4);
            v3
        };
        let v5 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_precision();
        if (v0 == 0 || v5 == 0) {
            return 0
        };
        let v6 = (arg3 as u256) * (v5 as u256) / (v0 as u256);
        let (v7, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_base_liquidity_inner<T0>(arg0);
        let v9 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg0);
        let v10 = if (v6 < 4) {
            true
        } else if (v6 > 18446744073709551615) {
            true
        } else {
            !arg2 && arg3 < 4
        };
        if (v10) {
            return 0
        };
        if (arg2 && v6 > (v7 as u256) * 995 / 1000 || !arg2 && v6 > (v9 as u256) * 995 / 1000) {
            return 0
        };
        let v11 = if (arg2) {
            0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_buy_swap<T0, T1>(arg0, arg1, arg4, arg3)
        } else {
            0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulate_sell_swap<T0, T1>(arg0, arg1, arg4, arg3)
        };
        let v12 = v11;
        let (v13, v14, _, _, v17, _, _, _, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::simulation_result_inner(&v12);
        let v22 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_config<T0>(arg0);
        let (_, _, _, _, v27, v28) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_config_inner(&v22);
        let (v29, _, _, _, v33, v34, v35, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::quote_asset_info_inner(0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_asset_info<T0, T1>(arg0));
        let v37 = v34;
        let v38 = v33;
        if (arg2) {
            if (v29 == 0) {
                return 0
            };
            let v40 = if (0x1::option::is_some<u64>(&v38)) {
                *0x1::option::borrow<u64>(&v38)
            } else {
                v27
            };
            let v41 = (v17 as u256) * (v40 as u256) / (v29 as u256);
            let v42 = v41;
            if (0x1::option::is_some<u64>(&v37) && (*0x1::option::borrow<u64>(&v37) as u256) < v41) {
                v42 = (*0x1::option::borrow<u64>(&v37) as u256);
            };
            let v43 = if ((v9 as u256) + (arg3 as u256) > v42) {
                true
            } else if (v13 < v28) {
                true
            } else {
                v14 != 0
            };
            if (v43) {
                return 0
            };
            v13
        } else {
            if (v14 < v35 || v13 != 0) {
                return 0
            };
            v14
        }
    }

    public fun quote<T0, T1>(arg0: &mut 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::Plan, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: bool, arg4: &0x2::clock::Clock) {
        0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::hop<T0, T1>(arg0, 0x2::object::id_address<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1), arg3);
        let v0 = if (live<T0, T1>(arg2, arg4)) {
            if (live<T1, T0>(arg2, arg4)) {
                available<T0, T1>(arg1)
            } else {
                false
            }
        } else {
            false
        };
        let v1 = 0;
        while (v1 < 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::count(arg0)) {
            let v2 = if (v0) {
                output<T0, T1>(arg1, arg2, !arg3, 0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::input(arg0, v1), arg4)
            } else {
                0
            };
            0x573365228ed1563cf19e8128666dcba4bbc920fe7c477558dd2c705acf30c8cc::plan::output(arg0, v1, v2);
            v1 = v1 + 1;
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return 0x2::balance::zero<T1>()
        };
        let (v0, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg0, arg1, arg3, arg2, 0x1::option::none<u64>(), arg4);
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg2) == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return 0x2::balance::zero<T0>()
        };
        let (v0, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg0, arg1, arg3, arg2, 0x1::option::none<u64>(), arg4);
        0x2::balance::destroy_zero<T1>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

