module 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::trader {
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
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::safe_mul_div_u64(arg0, 10000 + arg1, 10000)
    }

    fun apply_bid_penalty(arg0: u64, arg1: u64) : u64 {
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::safe_mul_div_u64(arg0, 10000 - arg1, 10000)
    }

    fun assert_ask_allowed(arg0: u8) {
        assert!(arg0 != 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::mode_paused(), 4);
        assert!(arg0 == 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::mode_two_way() || arg0 == 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::mode_ask_only(), 2);
    }

    fun assert_ask_deviation<T0, T1>(arg0: &0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::PoolState<T0, T1>, arg1: u64, arg2: u64) {
        assert!(arg2 >= 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::safe_mul_div_u64(arg1, 10000 - 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::max_ask_deviation_bps<T0, T1>(arg0), 10000), 5);
    }

    fun assert_bid_allowed(arg0: u8) {
        assert!(arg0 != 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::mode_paused(), 4);
        assert!(arg0 == 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::mode_two_way() || arg0 == 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::mode_bid_only(), 2);
    }

    fun assert_bid_deviation<T0, T1>(arg0: &0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::PoolState<T0, T1>, arg1: u64, arg2: u64) {
        assert!(arg2 <= 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::safe_mul_div_u64(arg1, 10000 + 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::max_bid_deviation_bps<T0, T1>(arg0), 10000), 5);
    }

    fun assert_post_trade_inventory_for_sell_base<T0, T1>(arg0: &0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::PoolState<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        if (0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::inventory_block_ratio_bps<T0, T1>(arg0) == 0 || arg4 > 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_balance<T0, T1>(arg0)) {
            return
        };
        let v0 = base_ratio_bps_from_balances(0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_balance<T0, T1>(arg0) + arg3, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_balance<T0, T1>(arg0) - arg4, arg1, arg2, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_coin_decimals<T0, T1>(arg0), 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_coin_decimals<T0, T1>(arg0));
        if (0x1::option::is_none<u64>(&v0)) {
            return
        };
        let v1 = 0x1::option::destroy_some<u64>(v0);
        let v2 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::inventory_target_base_ratio_bps<T0, T1>(arg0);
        if (v1 > v2) {
            assert!(v1 - v2 < 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::inventory_block_ratio_bps<T0, T1>(arg0), 9);
        };
    }

    fun assert_post_trade_inventory_for_sell_quote<T0, T1>(arg0: &0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::PoolState<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        if (0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::inventory_block_ratio_bps<T0, T1>(arg0) == 0 || arg4 > 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_balance<T0, T1>(arg0)) {
            return
        };
        let v0 = base_ratio_bps_from_balances(0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_balance<T0, T1>(arg0) - arg4, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_balance<T0, T1>(arg0) + arg3, arg1, arg2, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_coin_decimals<T0, T1>(arg0), 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_coin_decimals<T0, T1>(arg0));
        if (0x1::option::is_none<u64>(&v0)) {
            return
        };
        let v1 = 0x1::option::destroy_some<u64>(v0);
        let v2 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::inventory_target_base_ratio_bps<T0, T1>(arg0);
        if (v1 < v2) {
            assert!(v2 - v1 < 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::inventory_block_ratio_bps<T0, T1>(arg0), 9);
        };
    }

    fun assert_trade_within_public_limit<T0, T1>(arg0: &0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::PoolState<T0, T1>, arg1: u64) {
        assert!(arg1 <= 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::max_public_trade_usd_notional<T0, T1>(arg0), 8);
    }

    fun base_ratio_bps_from_balances(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u8) : 0x1::option::Option<u64> {
        let v0 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::base_amount_to_usd_notional(arg0, arg2, arg4);
        let v1 = v0 + 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::quote_amount_to_usd_notional(arg1, arg3, arg5);
        if (v1 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::safe_mul_div_u64(v0, 10000, v1))
        }
    }

    fun effective_mode<T0, T1>(arg0: &0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::PoolState<T0, T1>, arg1: &0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::RegimeState, arg2: u64) : (u8, bool) {
        let v0 = if (arg2 >= 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::last_update_ts_ms(arg1)) {
            arg2 - 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::last_update_ts_ms(arg1)
        } else {
            0
        };
        if (v0 >= 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::stale_pause_gap_ms<T0, T1>(arg0)) {
            (0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::mode_paused(), v0 >= 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::stale_widen_gap_ms<T0, T1>(arg0))
        } else if (v0 >= 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::stale_one_way_gap_ms<T0, T1>(arg0)) {
            (0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::stale_one_way_mode(arg1), true)
        } else {
            (0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::directional_mode(arg1), v0 >= 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::stale_widen_gap_ms<T0, T1>(arg0))
        }
    }

    fun last_ask_bucket_step_notional(arg0: &0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::RegimeState) : u64 {
        let v0 = (0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::bucket_count(arg0) as u64);
        if (v0 == 1) {
            0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_ask_bucket_upper_notional(arg0, v0 - 1)
        } else {
            0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_ask_bucket_upper_notional(arg0, v0 - 1) - 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_ask_bucket_upper_notional(arg0, v0 - 2)
        }
    }

    fun last_bid_bucket_step_notional(arg0: &0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::RegimeState) : u64 {
        let v0 = (0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::bucket_count(arg0) as u64);
        if (v0 == 1) {
            0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_bid_bucket_upper_notional(arg0, v0 - 1)
        } else {
            0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_bid_bucket_upper_notional(arg0, v0 - 1) - 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_bid_bucket_upper_notional(arg0, v0 - 2)
        }
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun quote_sell_base_with_prices<T0, T1>(arg0: &0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::PoolState<T0, T1>, arg1: &mut 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::RegimeState, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, vector<u64>, u64, u8) {
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::assert_matching_regime<T0, T1>(arg0, arg1);
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::assert_trade_allowed<T0, T1>(arg0);
        assert_trade_within_public_limit<T0, T1>(arg0, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::base_amount_to_usd_notional(arg5, arg2, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_coin_decimals<T0, T1>(arg0)));
        let (v0, v1) = effective_mode<T0, T1>(arg0, arg1, arg4);
        assert_bid_allowed(v0);
        let v2 = if (v1) {
            0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::bid_penalty_bps<T0, T1>(arg0)
        } else {
            0
        };
        let v3 = v2 + 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::inventory_bid_penalty_bps(arg1);
        let v4 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::reference_price_from_usd(arg2, arg3, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_coin_decimals<T0, T1>(arg0), 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_coin_decimals<T0, T1>(arg0));
        let v5 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_base_one<T0, T1>(arg0);
        let v6 = (0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::bucket_count(arg1) as u64);
        assert!(v6 > 0, 1);
        let v7 = zero_vector(v6);
        let v8 = 0;
        let v9 = arg5;
        let v10 = 0;
        let v11 = 0;
        let v12 = 0;
        while (v11 < v6 && v9 > 0) {
            let v13 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_bid_remaining_notional(arg1, v11);
            if (v13 > 0) {
                let v14 = min_u64(v9, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::safe_mul_div_u64(v13, v5, arg2));
                if (v14 > 0) {
                    let v15 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_bid_price(arg1, v11);
                    let v16 = v15;
                    assert!(v15 > 0, 3);
                    if (v3 > 0) {
                        v16 = apply_bid_penalty(v15, v3);
                    };
                    assert_bid_deviation<T0, T1>(arg0, v4, v16);
                    let v17 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::base_amount_to_usd_notional(v14, arg2, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_coin_decimals<T0, T1>(arg0));
                    let v18 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::bid_remaining_notional_mut(arg1, v11);
                    *v18 = *v18 - v17;
                    0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::record_current_regime_bid_fill(arg1, v11, v17);
                    let v19 = &mut v7;
                    add_vector_value(v19, v11, v17);
                    v10 = v10 + 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::safe_mul_div_u64(v14, v16, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::get_one());
                    v9 = v9 - v14;
                    v12 = v16;
                };
            };
            v11 = v11 + 1;
        };
        if (v9 > 0) {
            let v20 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::safe_mul_div_u64(last_bid_bucket_step_notional(arg1), v5, arg2);
            let v21 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_bid_price(arg1, v6 - 1);
            assert!(v21 > 0, 3);
            while (v9 > 0) {
                let v22 = apply_bid_penalty(v21, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::bid_tail_penalty_bps<T0, T1>(arg0));
                v21 = v22;
                let v23 = if (v20 == 0) {
                    v9
                } else {
                    min_u64(v9, v20)
                };
                let v24 = v22;
                if (v3 > 0) {
                    v24 = apply_bid_penalty(v22, v3);
                };
                assert_bid_deviation<T0, T1>(arg0, v4, v24);
                let v25 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::base_amount_to_usd_notional(v23, arg2, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_coin_decimals<T0, T1>(arg0));
                0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::record_current_regime_tail_bid_fill(arg1, v25);
                v8 = v8 + v25;
                v10 = v10 + 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::safe_mul_div_u64(v23, v24, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::get_one());
                v9 = v9 - v23;
                v12 = v24;
            };
        };
        assert_post_trade_inventory_for_sell_base<T0, T1>(arg0, arg2, arg3, arg5, v10);
        (v10, v12, v7, v8, v0)
    }

    fun quote_sell_quote_with_prices<T0, T1>(arg0: &0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::PoolState<T0, T1>, arg1: &mut 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::RegimeState, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, vector<u64>, u64, u8) {
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::assert_matching_regime<T0, T1>(arg0, arg1);
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::assert_trade_allowed<T0, T1>(arg0);
        assert_trade_within_public_limit<T0, T1>(arg0, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::quote_amount_to_usd_notional(arg5, arg3, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_coin_decimals<T0, T1>(arg0)));
        let (v0, v1) = effective_mode<T0, T1>(arg0, arg1, arg4);
        assert_ask_allowed(v0);
        let v2 = if (v1) {
            0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::ask_penalty_bps<T0, T1>(arg0)
        } else {
            0
        };
        let v3 = v2 + 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::inventory_ask_penalty_bps(arg1);
        let v4 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::reference_price_from_usd(arg2, arg3, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_coin_decimals<T0, T1>(arg0), 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_coin_decimals<T0, T1>(arg0));
        let v5 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_quote_one<T0, T1>(arg0);
        let v6 = (0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::bucket_count(arg1) as u64);
        assert!(v6 > 0, 1);
        let v7 = zero_vector(v6);
        let v8 = 0;
        let v9 = arg5;
        let v10 = 0;
        let v11 = 0;
        let v12 = 0;
        while (v11 < v6 && v9 > 0) {
            let v13 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_ask_remaining_notional(arg1, v11);
            if (v13 > 0) {
                let v14 = min_u64(v9, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::safe_mul_div_u64(v13, v5, arg3));
                if (v14 > 0) {
                    let v15 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_ask_price(arg1, v11);
                    let v16 = v15;
                    assert!(v15 > 0, 3);
                    if (v3 > 0) {
                        v16 = apply_ask_penalty(v15, v3);
                    };
                    assert_ask_deviation<T0, T1>(arg0, v4, v16);
                    let v17 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::quote_amount_to_usd_notional(v14, arg3, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_coin_decimals<T0, T1>(arg0));
                    let v18 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::ask_remaining_notional_mut(arg1, v11);
                    *v18 = *v18 - v17;
                    0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::record_current_regime_ask_fill(arg1, v11, v17);
                    let v19 = &mut v7;
                    add_vector_value(v19, v11, v17);
                    v10 = v10 + 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::safe_mul_div_u64(v14, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::get_one(), v16);
                    v9 = v9 - v14;
                    v12 = v16;
                };
            };
            v11 = v11 + 1;
        };
        if (v9 > 0) {
            let v20 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::safe_mul_div_u64(last_ask_bucket_step_notional(arg1), v5, arg3);
            let v21 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_ask_price(arg1, v6 - 1);
            assert!(v21 > 0, 3);
            while (v9 > 0) {
                let v22 = apply_ask_penalty(v21, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::ask_tail_penalty_bps<T0, T1>(arg0));
                v21 = v22;
                let v23 = if (v20 == 0) {
                    v9
                } else {
                    min_u64(v9, v20)
                };
                let v24 = v22;
                if (v3 > 0) {
                    v24 = apply_ask_penalty(v22, v3);
                };
                assert_ask_deviation<T0, T1>(arg0, v4, v24);
                let v25 = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::quote_amount_to_usd_notional(v23, arg3, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_coin_decimals<T0, T1>(arg0));
                0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::record_current_regime_tail_ask_fill(arg1, v25);
                v8 = v8 + v25;
                v10 = v10 + 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::safe_mul_div_u64(v23, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::safe_math::get_one(), v24);
                v9 = v9 - v23;
                v12 = v24;
            };
        };
        assert_post_trade_inventory_for_sell_quote<T0, T1>(arg0, arg2, arg3, arg5, v10);
        (v10, v12, v7, v8, v0)
    }

    public fun swap_exact_in_base_pro<T0, T1>(arg0: &mut 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::PoolState<T0, T1>, arg1: &mut 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::assert_pool_version<T0, T1>(arg0);
        let (v0, v1, _) = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::current_market_prices<T0, T1>(arg0, arg3, arg2);
        swap_exact_in_base_with_prices<T0, T1>(arg0, arg1, v0, v1, 0x2::clock::timestamp_ms(arg2), arg4, arg5, arg6, arg7)
    }

    public fun swap_exact_in_base_pyth_core<T0, T1>(arg0: &mut 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::PoolState<T0, T1>, arg1: &mut 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::assert_pool_version<T0, T1>(arg0);
        let (v0, v1, _) = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::current_market_prices_pyth_core<T0, T1>(arg0, arg3, arg4, arg2);
        swap_exact_in_base_with_prices<T0, T1>(arg0, arg1, v0, v1, 0x2::clock::timestamp_ms(arg2), arg5, arg6, arg7, arg8)
    }

    public(friend) fun swap_exact_in_base_with_prices<T0, T1>(arg0: &mut 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::PoolState<T0, T1>, arg1: &mut 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::RegimeState, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2, v3, v4) = quote_sell_base_with_prices<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        assert!(v0 >= arg7, 6);
        assert!(0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_balance<T0, T1>(arg0) >= v0, 7);
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_coin_pay_in<T0, T1>(arg0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg5), arg6));
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::increase_trade_num<T0, T1>(arg0);
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::record_current_regime_trade(arg1);
        let v5 = SwapEvent{
            pool_id                    : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::pool_id<T0, T1>(arg0),
            is_sell_base               : true,
            amount_in                  : arg6,
            amount_out                 : v0,
            last_price                 : v1,
            base_usd_price             : arg2,
            quote_usd_price            : arg3,
            pool_base_balance          : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_balance<T0, T1>(arg0),
            pool_quote_balance         : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_balance<T0, T1>(arg0),
            trade_num                  : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::trade_num<T0, T1>(arg0),
            regime_version             : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::regime_version(arg1),
            trade_notional_usd         : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::base_amount_to_usd_notional(arg6, arg2, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_coin_decimals<T0, T1>(arg0)),
            filled_bid_notional_usd    : v2,
            filled_ask_notional_usd    : zero_vector((0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::bucket_count(arg1) as u64)),
            tail_notional_usd          : v3,
            effective_mode             : v4,
            bid_remaining_notional_usd : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_bid_remaining_notional_vec(arg1),
            ask_remaining_notional_usd : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_ask_remaining_notional_vec(arg1),
        };
        0x2::event::emit<SwapEvent>(v5);
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_coin_pay_out<T0, T1>(arg0, v0, arg8)
    }

    public fun swap_exact_in_quote_pro<T0, T1>(arg0: &mut 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::PoolState<T0, T1>, arg1: &mut 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::assert_pool_version<T0, T1>(arg0);
        let (v0, v1, _) = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::current_market_prices<T0, T1>(arg0, arg3, arg2);
        swap_exact_in_quote_with_prices<T0, T1>(arg0, arg1, v0, v1, 0x2::clock::timestamp_ms(arg2), arg4, arg5, arg6, arg7)
    }

    public fun swap_exact_in_quote_pyth_core<T0, T1>(arg0: &mut 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::PoolState<T0, T1>, arg1: &mut 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::assert_pool_version<T0, T1>(arg0);
        let (v0, v1, _) = 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::current_market_prices_pyth_core<T0, T1>(arg0, arg3, arg4, arg2);
        swap_exact_in_quote_with_prices<T0, T1>(arg0, arg1, v0, v1, 0x2::clock::timestamp_ms(arg2), arg5, arg6, arg7, arg8)
    }

    public(friend) fun swap_exact_in_quote_with_prices<T0, T1>(arg0: &mut 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::PoolState<T0, T1>, arg1: &mut 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::RegimeState, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2, v3, v4) = quote_sell_quote_with_prices<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        assert!(v0 >= arg7, 6);
        assert!(0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_balance<T0, T1>(arg0) >= v0, 7);
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_coin_pay_in<T0, T1>(arg0, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg5), arg6));
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::increase_trade_num<T0, T1>(arg0);
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::record_current_regime_trade(arg1);
        let v5 = SwapEvent{
            pool_id                    : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::pool_id<T0, T1>(arg0),
            is_sell_base               : false,
            amount_in                  : arg6,
            amount_out                 : v0,
            last_price                 : v1,
            base_usd_price             : arg2,
            quote_usd_price            : arg3,
            pool_base_balance          : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_balance<T0, T1>(arg0),
            pool_quote_balance         : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_balance<T0, T1>(arg0),
            trade_num                  : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::trade_num<T0, T1>(arg0),
            regime_version             : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::regime_version(arg1),
            trade_notional_usd         : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::oracle::quote_amount_to_usd_notional(arg6, arg3, 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::quote_coin_decimals<T0, T1>(arg0)),
            filled_bid_notional_usd    : zero_vector((0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::bucket_count(arg1) as u64)),
            filled_ask_notional_usd    : v2,
            tail_notional_usd          : v3,
            effective_mode             : v4,
            bid_remaining_notional_usd : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_bid_remaining_notional_vec(arg1),
            ask_remaining_notional_usd : 0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::get_ask_remaining_notional_vec(arg1),
        };
        0x2::event::emit<SwapEvent>(v5);
        0xbed634d86d8830018d140a6bdaace9644f92928ee1ba6ae829062cfdab06b1a1::pool::base_coin_pay_out<T0, T1>(arg0, v0, arg8)
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

