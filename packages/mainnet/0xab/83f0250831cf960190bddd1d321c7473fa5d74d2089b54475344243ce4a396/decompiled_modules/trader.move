module 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::trader {
    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        is_sell_base: bool,
        amount_in: u64,
        amount_out: u64,
        last_price: u64,
        base_usd_price: u64,
        quote_usd_price: u64,
        pool_base_balance: u64,
        pool_quote_balance: u64,
        trade_num: u64,
        regime_version: u64,
        trade_notional_usd: u64,
        filled_bid_notional_usd: vector<u64>,
        filled_ask_notional_usd: vector<u64>,
        tail_notional_usd: u64,
        effective_mode: u8,
        bid_remaining_notional_usd: vector<u64>,
        ask_remaining_notional_usd: vector<u64>,
    }

    fun add_vector_value(arg0: &mut vector<u64>, arg1: u64, arg2: u64) {
        let v0 = 0x1::vector::borrow_mut<u64>(arg0, arg1);
        *v0 = *v0 + arg2;
    }

    fun apply_ask_penalty(arg0: u64, arg1: u64) : u64 {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(arg0, 10000 + arg1, 10000)
    }

    fun apply_ask_penalty_numer(arg0: u64, arg1: u64) : u64 {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(arg0, 10000000 + arg1, 10000000)
    }

    fun apply_bid_penalty(arg0: u64, arg1: u64) : u64 {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(arg0, 10000 - arg1, 10000)
    }

    fun apply_bid_penalty_numer(arg0: u64, arg1: u64) : u64 {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(arg0, 10000000 - min_u64(arg1, 10000000), 10000000)
    }

    fun assert_ask_allowed(arg0: u8) {
        assert!(arg0 != 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_paused(), 4);
        assert!(arg0 == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_two_way() || arg0 == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_ask_only(), 2);
    }

    fun assert_ask_deviation<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: u64, arg2: u64) {
        assert!(arg2 >= 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(arg1, 10000 - 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::max_ask_deviation_bps<T0, T1>(arg0), 10000), 5);
    }

    fun assert_bid_allowed(arg0: u8) {
        assert!(arg0 != 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_paused(), 4);
        assert!(arg0 == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_two_way() || arg0 == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_bid_only(), 2);
    }

    fun assert_bid_deviation<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: u64, arg2: u64) {
        assert!(arg2 <= 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(arg1, 10000 + 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::max_bid_deviation_bps<T0, T1>(arg0), 10000), 5);
    }

    fun assert_post_trade_inventory_for_sell_base<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        if (0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_block_ratio_bps<T0, T1>(arg0) == 0 || arg4 > 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_balance<T0, T1>(arg0)) {
            return
        };
        let v0 = base_ratio_bps_from_balances(0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_balance<T0, T1>(arg0) + arg3, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_balance<T0, T1>(arg0) - arg4, arg1, arg2, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_coin_decimals<T0, T1>(arg0), 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_coin_decimals<T0, T1>(arg0));
        if (0x1::option::is_none<u64>(&v0)) {
            return
        };
        let v1 = 0x1::option::destroy_some<u64>(v0);
        let v2 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_target_base_ratio_bps<T0, T1>(arg0);
        if (v1 > v2) {
            assert!(v1 - v2 < 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_block_ratio_bps<T0, T1>(arg0), 9);
        };
    }

    fun assert_post_trade_inventory_for_sell_quote<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        if (0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_block_ratio_bps<T0, T1>(arg0) == 0 || arg4 > 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_balance<T0, T1>(arg0)) {
            return
        };
        let v0 = base_ratio_bps_from_balances(0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_balance<T0, T1>(arg0) - arg4, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_balance<T0, T1>(arg0) + arg3, arg1, arg2, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_coin_decimals<T0, T1>(arg0), 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_coin_decimals<T0, T1>(arg0));
        if (0x1::option::is_none<u64>(&v0)) {
            return
        };
        let v1 = 0x1::option::destroy_some<u64>(v0);
        let v2 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_target_base_ratio_bps<T0, T1>(arg0);
        if (v1 < v2) {
            assert!(v2 - v1 < 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_block_ratio_bps<T0, T1>(arg0), 9);
        };
    }

    fun assert_trade_within_public_limit<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: u64) {
        assert!(arg1 <= 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::max_public_trade_usd_notional<T0, T1>(arg0), 8);
    }

    fun base_ratio_bps_from_balances(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u8) : 0x1::option::Option<u64> {
        let v0 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::base_amount_to_usd_notional(arg0, arg2, arg4);
        let v1 = v0 + 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::quote_amount_to_usd_notional(arg1, arg3, arg5);
        if (v1 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(v0, 10000, v1))
        }
    }

    fun effective_mode<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: u64) : (u8, bool) {
        if (0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::directional_mode(arg1) == 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_paused()) {
            (0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_paused(), arg2 >= 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::stale_widen_gap_ms<T0, T1>(arg0))
        } else if (arg2 >= 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::stale_pause_gap_ms<T0, T1>(arg0)) {
            (0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::mode_paused(), arg2 >= 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::stale_widen_gap_ms<T0, T1>(arg0))
        } else if (arg2 >= 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::stale_one_way_gap_ms<T0, T1>(arg0)) {
            (0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::stale_one_way_mode(arg1), true)
        } else {
            (0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::directional_mode(arg1), arg2 >= 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::stale_widen_gap_ms<T0, T1>(arg0))
        }
    }

    fun last_ask_bucket_step_notional(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState) : u64 {
        let v0 = (0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::bucket_count(arg0) as u64);
        if (v0 == 1) {
            0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_ask_bucket_upper_notional(arg0, v0 - 1)
        } else {
            0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_ask_bucket_upper_notional(arg0, v0 - 1) - 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_ask_bucket_upper_notional(arg0, v0 - 2)
        }
    }

    fun last_bid_bucket_step_notional(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState) : u64 {
        let v0 = (0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::bucket_count(arg0) as u64);
        if (v0 == 1) {
            0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_bid_bucket_upper_notional(arg0, v0 - 1)
        } else {
            0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_bid_bucket_upper_notional(arg0, v0 - 1) - 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_bid_bucket_upper_notional(arg0, v0 - 2)
        }
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun quote_sell_base_with_prices<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, vector<u64>, u64, u8) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_matching_regime<T0, T1>(arg0, arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_trade_allowed<T0, T1>(arg0);
        assert_trade_within_public_limit<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::base_amount_to_usd_notional(arg5, arg2, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_coin_decimals<T0, T1>(arg0)));
        let v0 = regime_gap_ms(arg1, arg4);
        let (v1, v2) = effective_mode<T0, T1>(arg0, arg1, v0);
        assert_bid_allowed(v1);
        let v3 = if (v2) {
            0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::bid_penalty_bps<T0, T1>(arg0)
        } else {
            0
        };
        let (v4, v5) = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::time_penalty_config<T0, T1>(arg0);
        let v6 = total_penalty_numer(v3 + 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_bid_penalty_bps(arg1), v4, v5, v0);
        let v7 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::reference_price_from_usd(arg2, arg3, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_coin_decimals<T0, T1>(arg0), 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_coin_decimals<T0, T1>(arg0));
        let v8 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_base_one<T0, T1>(arg0);
        let v9 = (0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::bucket_count(arg1) as u64);
        assert!(v9 > 0, 1);
        let v10 = zero_vector(v9);
        let v11 = 0;
        let v12 = arg5;
        let v13 = 0;
        let v14 = 0;
        let v15 = 0;
        while (v14 < v9 && v12 > 0) {
            let v16 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_bid_remaining_notional(arg1, v14);
            if (v16 > 0) {
                let v17 = min_u64(v12, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(v16, v8, arg2));
                if (v17 > 0) {
                    let v18 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_bid_price(arg1, v14);
                    let v19 = v18;
                    assert!(v18 > 0, 3);
                    if (v6 > 0) {
                        v19 = apply_bid_penalty_numer(v18, v6);
                    };
                    assert_bid_deviation<T0, T1>(arg0, v7, v19);
                    let v20 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::base_amount_to_usd_notional(v17, arg2, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_coin_decimals<T0, T1>(arg0));
                    let v21 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::bid_remaining_notional_mut(arg1, v14);
                    *v21 = *v21 - v20;
                    0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::record_current_regime_bid_fill(arg1, v14, v20);
                    let v22 = &mut v10;
                    add_vector_value(v22, v14, v20);
                    v13 = v13 + 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(v17, v19, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::get_one());
                    v12 = v12 - v17;
                    v15 = v19;
                };
            };
            v14 = v14 + 1;
        };
        if (v12 > 0) {
            let v23 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(last_bid_bucket_step_notional(arg1), v8, arg2);
            let v24 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_bid_price(arg1, v9 - 1);
            assert!(v24 > 0, 3);
            while (v12 > 0) {
                let v25 = apply_bid_penalty(v24, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::bid_tail_penalty_bps<T0, T1>(arg0));
                v24 = v25;
                let v26 = if (v23 == 0) {
                    v12
                } else {
                    min_u64(v12, v23)
                };
                let v27 = v25;
                if (v6 > 0) {
                    v27 = apply_bid_penalty_numer(v25, v6);
                };
                assert_bid_deviation<T0, T1>(arg0, v7, v27);
                let v28 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::base_amount_to_usd_notional(v26, arg2, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_coin_decimals<T0, T1>(arg0));
                0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::record_current_regime_tail_bid_fill(arg1, v28);
                v11 = v11 + v28;
                v13 = v13 + 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(v26, v27, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::get_one());
                v12 = v12 - v26;
                v15 = v27;
            };
        };
        assert_post_trade_inventory_for_sell_base<T0, T1>(arg0, arg2, arg3, arg5, v13);
        (v13, v15, v10, v11, v1)
    }

    fun quote_sell_quote_with_prices<T0, T1>(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, vector<u64>, u64, u8) {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_matching_regime<T0, T1>(arg0, arg1);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_trade_allowed<T0, T1>(arg0);
        assert_trade_within_public_limit<T0, T1>(arg0, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::quote_amount_to_usd_notional(arg5, arg3, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_coin_decimals<T0, T1>(arg0)));
        let v0 = regime_gap_ms(arg1, arg4);
        let (v1, v2) = effective_mode<T0, T1>(arg0, arg1, v0);
        assert_ask_allowed(v1);
        let v3 = if (v2) {
            0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::ask_penalty_bps<T0, T1>(arg0)
        } else {
            0
        };
        let (v4, v5) = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::time_penalty_config<T0, T1>(arg0);
        let v6 = total_penalty_numer(v3 + 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::inventory_ask_penalty_bps(arg1), v4, v5, v0);
        let v7 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::reference_price_from_usd(arg2, arg3, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_coin_decimals<T0, T1>(arg0), 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_coin_decimals<T0, T1>(arg0));
        let v8 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_quote_one<T0, T1>(arg0);
        let v9 = (0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::bucket_count(arg1) as u64);
        assert!(v9 > 0, 1);
        let v10 = zero_vector(v9);
        let v11 = 0;
        let v12 = arg5;
        let v13 = 0;
        let v14 = 0;
        let v15 = 0;
        while (v14 < v9 && v12 > 0) {
            let v16 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_ask_remaining_notional(arg1, v14);
            if (v16 > 0) {
                let v17 = min_u64(v12, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(v16, v8, arg3));
                if (v17 > 0) {
                    let v18 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_ask_price(arg1, v14);
                    let v19 = v18;
                    assert!(v18 > 0, 3);
                    if (v6 > 0) {
                        v19 = apply_ask_penalty_numer(v18, v6);
                    };
                    assert_ask_deviation<T0, T1>(arg0, v7, v19);
                    let v20 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::quote_amount_to_usd_notional(v17, arg3, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_coin_decimals<T0, T1>(arg0));
                    let v21 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::ask_remaining_notional_mut(arg1, v14);
                    *v21 = *v21 - v20;
                    0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::record_current_regime_ask_fill(arg1, v14, v20);
                    let v22 = &mut v10;
                    add_vector_value(v22, v14, v20);
                    v13 = v13 + 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(v17, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::get_one(), v19);
                    v12 = v12 - v17;
                    v15 = v19;
                };
            };
            v14 = v14 + 1;
        };
        if (v12 > 0) {
            let v23 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(last_ask_bucket_step_notional(arg1), v8, arg3);
            let v24 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_ask_price(arg1, v9 - 1);
            assert!(v24 > 0, 3);
            while (v12 > 0) {
                let v25 = apply_ask_penalty(v24, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::ask_tail_penalty_bps<T0, T1>(arg0));
                v24 = v25;
                let v26 = if (v23 == 0) {
                    v12
                } else {
                    min_u64(v12, v23)
                };
                let v27 = v25;
                if (v6 > 0) {
                    v27 = apply_ask_penalty_numer(v25, v6);
                };
                assert_ask_deviation<T0, T1>(arg0, v7, v27);
                let v28 = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::quote_amount_to_usd_notional(v26, arg3, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_coin_decimals<T0, T1>(arg0));
                0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::record_current_regime_tail_ask_fill(arg1, v28);
                v11 = v11 + v28;
                v13 = v13 + 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(v26, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::get_one(), v27);
                v12 = v12 - v26;
                v15 = v27;
            };
        };
        assert_post_trade_inventory_for_sell_quote<T0, T1>(arg0, arg2, arg3, arg5, v13);
        (v13, v15, v10, v11, v1)
    }

    fun regime_gap_ms(arg0: &0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg1: u64) : u64 {
        if (arg1 >= 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::last_update_ts_ms(arg0)) {
            arg1 - 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::last_update_ts_ms(arg0)
        } else {
            0
        }
    }

    public fun swap_exact_in_base_pro<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg0);
        let (v0, v1, _) = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::current_market_prices<T0, T1>(arg0, arg3, arg2);
        swap_exact_in_base_with_prices<T0, T1>(arg0, arg1, v0, v1, 0x2::clock::timestamp_ms(arg2), arg4, arg5, arg6, arg7)
    }

    public fun swap_exact_in_base_pyth_core<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg0);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_legacy_pyth_core_allowed<T0, T1>(arg0);
        let (v0, v1, _) = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::current_market_prices_pyth_core<T0, T1>(arg0, arg3, arg4, arg2);
        swap_exact_in_base_with_prices<T0, T1>(arg0, arg1, v0, v1, 0x2::clock::timestamp_ms(arg2), arg5, arg6, arg7, arg8)
    }

    public fun swap_exact_in_base_pyth_core_v2<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg0);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_v2_pyth_core_allowed<T0, T1>(arg0);
        let (v0, v1, _) = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::current_market_prices_pyth_core_v2<T0, T1>(arg0, arg3, arg4, arg2);
        swap_exact_in_base_with_prices<T0, T1>(arg0, arg1, v0, v1, 0x2::clock::timestamp_ms(arg2), arg5, arg6, arg7, arg8)
    }

    public(friend) fun swap_exact_in_base_with_prices<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2, v3, v4) = quote_sell_base_with_prices<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        assert!(v0 >= arg7, 6);
        assert!(0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_balance<T0, T1>(arg0) >= v0, 7);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_coin_pay_in<T0, T1>(arg0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg5), arg6));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::increase_trade_num<T0, T1>(arg0);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::record_current_regime_trade(arg1);
        let v5 = SwapEvent{
            pool_id                    : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg0),
            is_sell_base               : true,
            amount_in                  : arg6,
            amount_out                 : v0,
            last_price                 : v1,
            base_usd_price             : arg2,
            quote_usd_price            : arg3,
            pool_base_balance          : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_balance<T0, T1>(arg0),
            pool_quote_balance         : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_balance<T0, T1>(arg0),
            trade_num                  : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::trade_num<T0, T1>(arg0),
            regime_version             : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::regime_version(arg1),
            trade_notional_usd         : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::base_amount_to_usd_notional(arg6, arg2, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_coin_decimals<T0, T1>(arg0)),
            filled_bid_notional_usd    : v2,
            filled_ask_notional_usd    : zero_vector((0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::bucket_count(arg1) as u64)),
            tail_notional_usd          : v3,
            effective_mode             : v4,
            bid_remaining_notional_usd : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_bid_remaining_notional_vec(arg1),
            ask_remaining_notional_usd : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_ask_remaining_notional_vec(arg1),
        };
        0x2::event::emit<SwapEvent>(v5);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_coin_pay_out<T0, T1>(arg0, v0, arg8)
    }

    public fun swap_exact_in_quote_pro<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg0);
        let (v0, v1, _) = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::current_market_prices<T0, T1>(arg0, arg3, arg2);
        swap_exact_in_quote_with_prices<T0, T1>(arg0, arg1, v0, v1, 0x2::clock::timestamp_ms(arg2), arg4, arg5, arg6, arg7)
    }

    public fun swap_exact_in_quote_pyth_core<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg0);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_legacy_pyth_core_allowed<T0, T1>(arg0);
        let (v0, v1, _) = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::current_market_prices_pyth_core<T0, T1>(arg0, arg3, arg4, arg2);
        swap_exact_in_quote_with_prices<T0, T1>(arg0, arg1, v0, v1, 0x2::clock::timestamp_ms(arg2), arg5, arg6, arg7, arg8)
    }

    public fun swap_exact_in_quote_pyth_core_v2<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg5: &mut 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_pool_version<T0, T1>(arg0);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::assert_v2_pyth_core_allowed<T0, T1>(arg0);
        let (v0, v1, _) = 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::current_market_prices_pyth_core_v2<T0, T1>(arg0, arg3, arg4, arg2);
        swap_exact_in_quote_with_prices<T0, T1>(arg0, arg1, v0, v1, 0x2::clock::timestamp_ms(arg2), arg5, arg6, arg7, arg8)
    }

    public(friend) fun swap_exact_in_quote_with_prices<T0, T1>(arg0: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::PoolState<T0, T1>, arg1: &mut 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::RegimeState, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2, v3, v4) = quote_sell_quote_with_prices<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        assert!(v0 >= arg7, 6);
        assert!(0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_balance<T0, T1>(arg0) >= v0, 7);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_coin_pay_in<T0, T1>(arg0, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg5), arg6));
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::increase_trade_num<T0, T1>(arg0);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::record_current_regime_trade(arg1);
        let v5 = SwapEvent{
            pool_id                    : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::pool_id<T0, T1>(arg0),
            is_sell_base               : false,
            amount_in                  : arg6,
            amount_out                 : v0,
            last_price                 : v1,
            base_usd_price             : arg2,
            quote_usd_price            : arg3,
            pool_base_balance          : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_balance<T0, T1>(arg0),
            pool_quote_balance         : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_balance<T0, T1>(arg0),
            trade_num                  : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::trade_num<T0, T1>(arg0),
            regime_version             : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::regime_version(arg1),
            trade_notional_usd         : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::oracle::quote_amount_to_usd_notional(arg6, arg3, 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::quote_coin_decimals<T0, T1>(arg0)),
            filled_bid_notional_usd    : zero_vector((0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::bucket_count(arg1) as u64)),
            filled_ask_notional_usd    : v2,
            tail_notional_usd          : v3,
            effective_mode             : v4,
            bid_remaining_notional_usd : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_bid_remaining_notional_vec(arg1),
            ask_remaining_notional_usd : 0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::get_ask_remaining_notional_vec(arg1),
        };
        0x2::event::emit<SwapEvent>(v5);
        0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::pool::base_coin_pay_out<T0, T1>(arg0, v0, arg8)
    }

    fun total_penalty_numer(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg1 > 0 && arg2 > 0) {
            0x70b1d191657bd7dd84711940efb08192a74a2ea30ef66d3f37e869c668894e53::safe_math::safe_mul_div_u64(arg1 * 1000, arg3, arg2)
        } else {
            0
        };
        arg0 * 1000 + v0
    }

    fun zero_vector(arg0: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

