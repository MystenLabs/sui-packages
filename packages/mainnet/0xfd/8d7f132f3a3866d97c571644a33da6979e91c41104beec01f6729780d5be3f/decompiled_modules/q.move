module 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::q {
    public fun bluefin<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg0, arg1, true, arg2, limit(arg1));
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v0) || 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v0) != 0) {
            0
        } else {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v0)
        }
    }

    public fun bolt_available<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>) : bool {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_pool_info<T0>(arg0);
        let (_, _, _, _, _, _, v7) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::pool_info_inner(&v0);
        let (_, _, _, _, _, _, _, v15) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::quote_asset_info_inner(0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_asset_info<T0, T1>(arg0));
        !v7 && v15
    }

    public fun bolt_live<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::get_price<T0, T1>(arg0);
        let v1 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::price_response_pair_data(&v0);
        if (0x1::option::is_none<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::PriceData>(&v1)) {
            return false
        };
        let v2 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::price_data_price<T0, T1>(0x1::option::borrow<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::PriceData>(&v1));
        0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::live(0x2::clock::timestamp_ms(arg1), 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::get_expiry<T0, T1>(&v2)) && 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::get_price<T0, T1>(&v2) > 0
    }

    public fun bolt_out<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) : (u64, u64) {
        if (arg3 == 0) {
            return (0, 0)
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
            return (0, 0)
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
            return (0, 0)
        };
        if (arg2 && v6 > (v7 as u256) * 995 / 1000 || !arg2 && v6 > (v9 as u256) * 995 / 1000) {
            return (0, 0)
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
        let v39 = if (arg2) {
            if (v29 == 0) {
                return (0, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::bolt_boundary(arg2, v9, v17, v0, v5))
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
                return (0, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::bolt_boundary(arg2, v9, v17, v0, v5))
            };
            v13
        } else {
            if (v14 < v35 || v13 != 0) {
                return (0, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::bolt_boundary(arg2, v9, v17, v0, v5))
            };
            v14
        };
        (v39, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::bolt_boundary(arg2, v9, v17, v0, v5))
    }

    public fun bolt_prices<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg1: &0x2::clock::Clock) : (u128, u128) {
        let (v0, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T0, T1>(arg0, arg1);
        let (v2, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T1, T0>(arg0, arg1);
        let v4 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_precision();
        let v5 = if (v0 == 0) {
            true
        } else if (v2 == 0) {
            true
        } else {
            v4 == 0
        };
        if (v5) {
            return (0, 0)
        };
        ((((v0 as u256) * 1000000000 / (v4 as u256)) as u128), (((v4 as u256) * 1000000000 / (v2 as u256)) as u128))
    }

    public fun book<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        if (arg2 == 0) {
            return (0, 0)
        };
        let (v0, v1) = if (arg1) {
            let (v2, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, arg2, arg3);
            (v2, v3)
        } else {
            let (v5, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, arg2, arg3);
            (v5, v6)
        };
        if (arg1) {
            (v0, v1)
        } else {
            (v1, v0)
        }
    }

    public fun book_grid<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64) : (u64, u64, u64, u64) {
        let (_, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v6 = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::book_input(v1, v3);
        let v7 = 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::book_input(0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::round_up(v2, v1), v3);
        (v6, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::ceil_div((v6 as u256) * (arg1 as u256), 1000000000), v7, 0xfd8d7f132f3a3866d97c571644a33da6979e91c41104beec01f6729780d5be3f::math::ceil_div((v7 as u256) * (arg1 as u256), 1000000000))
    }

    public fun cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg1, true, arg2);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v0)) {
            0
        } else {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0)
        }
    }

    public fun limit(arg0: bool) : u128 {
        if (arg0) {
            4295048017
        } else {
            79226673515401279992447579054
        }
    }

    public fun turbos<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let (_, v1, v2, v3) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_swap::compute_swap(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), limit(arg1), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0), (arg2 as u128), true, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg0));
        if ((v1 as u256) + (v3 as u256) != (arg2 as u256) || v2 > 18446744073709551615) {
            0
        } else {
            (v2 as u64)
        }
    }

    // decompiled from Move bytecode v7
}

