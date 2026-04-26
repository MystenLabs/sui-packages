module 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::trader {
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
        bid_remaining_notional_usd: vector<u64>,
        ask_remaining_notional_usd: vector<u64>,
    }

    fun apply_ask_penalty(arg0: u64, arg1: u64) : u64 {
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::safe_mul_div_u64(arg0, 10000 + arg1, 10000)
    }

    fun apply_bid_penalty(arg0: u64, arg1: u64) : u64 {
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::safe_mul_div_u64(arg0, 10000 - arg1, 10000)
    }

    fun assert_ask_allowed(arg0: u8) {
        assert!(arg0 != 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::mode_paused(), 4);
        assert!(arg0 == 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::mode_two_way() || arg0 == 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::mode_ask_only(), 2);
    }

    fun assert_ask_deviation<T0, T1>(arg0: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: u64, arg2: u64) {
        assert!(arg2 <= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::safe_mul_div_u64(arg1, 10000 + 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::max_ask_deviation_bps<T0, T1>(arg0), 10000), 5);
    }

    fun assert_bid_allowed(arg0: u8) {
        assert!(arg0 != 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::mode_paused(), 4);
        assert!(arg0 == 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::mode_two_way() || arg0 == 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::mode_bid_only(), 2);
    }

    fun assert_bid_deviation<T0, T1>(arg0: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: u64, arg2: u64) {
        assert!(arg2 >= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::safe_mul_div_u64(arg1, 10000 - 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::max_bid_deviation_bps<T0, T1>(arg0), 10000), 5);
    }

    fun assert_trade_within_public_limit<T0, T1>(arg0: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: u64) {
        assert!(arg1 <= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::max_public_trade_usd_notional<T0, T1>(arg0), 8);
    }

    fun current_base_ratio_bps<T0, T1>(arg0: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: u64, arg2: u64) : 0x1::option::Option<u64> {
        let v0 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::oracle::base_amount_to_usd_notional(0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::base_balance<T0, T1>(arg0), arg1, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::base_coin_decimals<T0, T1>(arg0));
        let v1 = v0 + 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::oracle::quote_amount_to_usd_notional(0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::quote_balance<T0, T1>(arg0), arg2, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::quote_coin_decimals<T0, T1>(arg0));
        if (v1 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::safe_mul_div_u64(v0, 10000, v1))
        }
    }

    fun effective_mode<T0, T1>(arg0: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::RegimeState, arg2: u64) : (u8, bool) {
        let v0 = if (arg2 >= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::last_update_ts_ms(arg1)) {
            arg2 - 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::last_update_ts_ms(arg1)
        } else {
            0
        };
        if (v0 >= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::stale_pause_gap_ms<T0, T1>(arg0)) {
            (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::mode_paused(), v0 >= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::stale_widen_gap_ms<T0, T1>(arg0))
        } else if (v0 >= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::stale_one_way_gap_ms<T0, T1>(arg0)) {
            (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::stale_one_way_mode(arg1), true)
        } else {
            (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::directional_mode(arg1), v0 >= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::stale_widen_gap_ms<T0, T1>(arg0))
        }
    }

    fun flow_penalty_for_ask<T0, T1>(arg0: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: u64) : u64 {
        if (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_block_notional_usd<T0, T1>(arg0) > 0) {
            assert!(arg1 < 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_block_notional_usd<T0, T1>(arg0), 10);
        };
        if (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_critical_notional_usd<T0, T1>(arg0) > 0 && arg1 >= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_critical_notional_usd<T0, T1>(arg0)) {
            0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_critical_penalty_bps<T0, T1>(arg0)
        } else if (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_warn_notional_usd<T0, T1>(arg0) > 0 && arg1 >= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_warn_notional_usd<T0, T1>(arg0)) {
            0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_warn_penalty_bps<T0, T1>(arg0)
        } else {
            0
        }
    }

    fun flow_penalty_for_bid<T0, T1>(arg0: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: u64) : u64 {
        if (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_block_notional_usd<T0, T1>(arg0) > 0) {
            assert!(arg1 < 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_block_notional_usd<T0, T1>(arg0), 10);
        };
        if (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_critical_notional_usd<T0, T1>(arg0) > 0 && arg1 >= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_critical_notional_usd<T0, T1>(arg0)) {
            0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_critical_penalty_bps<T0, T1>(arg0)
        } else if (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_warn_notional_usd<T0, T1>(arg0) > 0 && arg1 >= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_warn_notional_usd<T0, T1>(arg0)) {
            0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::flow_warn_penalty_bps<T0, T1>(arg0)
        } else {
            0
        }
    }

    fun inventory_penalty_for_sell_base<T0, T1>(arg0: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let v0 = current_base_ratio_bps<T0, T1>(arg0, arg1, arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0
        };
        let v1 = 0x1::option::destroy_some<u64>(v0);
        let v2 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_target_base_ratio_bps<T0, T1>(arg0);
        if (v1 <= v2) {
            return 0
        };
        let v3 = v1 - v2;
        if (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_block_ratio_bps<T0, T1>(arg0) > 0) {
            assert!(v3 < 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_block_ratio_bps<T0, T1>(arg0), 9);
        };
        if (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_critical_ratio_bps<T0, T1>(arg0) > 0 && v3 >= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_critical_ratio_bps<T0, T1>(arg0)) {
            0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_critical_penalty_bps<T0, T1>(arg0)
        } else if (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_warn_ratio_bps<T0, T1>(arg0) > 0 && v3 >= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_warn_ratio_bps<T0, T1>(arg0)) {
            0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_warn_penalty_bps<T0, T1>(arg0)
        } else {
            0
        }
    }

    fun inventory_penalty_for_sell_quote<T0, T1>(arg0: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let v0 = current_base_ratio_bps<T0, T1>(arg0, arg1, arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0
        };
        let v1 = 0x1::option::destroy_some<u64>(v0);
        let v2 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_target_base_ratio_bps<T0, T1>(arg0);
        if (v1 >= v2) {
            return 0
        };
        let v3 = v2 - v1;
        if (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_block_ratio_bps<T0, T1>(arg0) > 0) {
            assert!(v3 < 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_block_ratio_bps<T0, T1>(arg0), 9);
        };
        if (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_critical_ratio_bps<T0, T1>(arg0) > 0 && v3 >= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_critical_ratio_bps<T0, T1>(arg0)) {
            0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_critical_penalty_bps<T0, T1>(arg0)
        } else if (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_warn_ratio_bps<T0, T1>(arg0) > 0 && v3 >= 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_warn_ratio_bps<T0, T1>(arg0)) {
            0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::inventory_warn_penalty_bps<T0, T1>(arg0)
        } else {
            0
        }
    }

    fun last_ask_bucket_step_notional(arg0: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::RegimeState) : u64 {
        let v0 = (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::bucket_count(arg0) as u64);
        if (v0 == 1) {
            0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_ask_bucket_upper_notional(arg0, v0 - 1)
        } else {
            0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_ask_bucket_upper_notional(arg0, v0 - 1) - 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_ask_bucket_upper_notional(arg0, v0 - 2)
        }
    }

    fun last_bid_bucket_step_notional(arg0: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::RegimeState) : u64 {
        let v0 = (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::bucket_count(arg0) as u64);
        if (v0 == 1) {
            0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_bid_bucket_upper_notional(arg0, v0 - 1)
        } else {
            0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_bid_bucket_upper_notional(arg0, v0 - 1) - 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_bid_bucket_upper_notional(arg0, v0 - 2)
        }
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun projected_ask_flow_notional<T0, T1>(arg0: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: &mut 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::RegimeState, arg2: u64, arg3: u64) : u64 {
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::current_recent_ask_flow<T0, T1>(arg0, arg1, arg2) + arg3
    }

    fun projected_bid_flow_notional<T0, T1>(arg0: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: &mut 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::RegimeState, arg2: u64, arg3: u64) : u64 {
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::current_recent_bid_flow<T0, T1>(arg0, arg1, arg2) + arg3
    }

    fun quote_sell_base_with_prices<T0, T1>(arg0: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: &mut 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::RegimeState, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64) {
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::assert_matching_regime<T0, T1>(arg0, arg1);
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::assert_trade_allowed<T0, T1>(arg0);
        let v0 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::oracle::base_amount_to_usd_notional(arg5, arg2, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::base_coin_decimals<T0, T1>(arg0));
        assert_trade_within_public_limit<T0, T1>(arg0, v0);
        let (v1, v2) = effective_mode<T0, T1>(arg0, arg1, arg4);
        assert_bid_allowed(v1);
        let v3 = if (v2) {
            0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::bid_penalty_bps<T0, T1>(arg0)
        } else {
            0
        };
        let v4 = projected_bid_flow_notional<T0, T1>(arg0, arg1, arg4, v0);
        let v5 = v3 + inventory_penalty_for_sell_base<T0, T1>(arg0, arg2, arg3) + flow_penalty_for_bid<T0, T1>(arg0, v4);
        let v6 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::oracle::reference_price_from_usd(arg2, arg3, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::base_coin_decimals<T0, T1>(arg0), 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::quote_coin_decimals<T0, T1>(arg0));
        let v7 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_base_one<T0, T1>(arg0);
        let v8 = (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::bucket_count(arg1) as u64);
        assert!(v8 > 0, 1);
        let v9 = arg5;
        let v10 = 0;
        let v11 = 0;
        let v12 = 0;
        while (v11 < v8 && v9 > 0) {
            let v13 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_bid_remaining_notional(arg1, v11);
            if (v13 > 0) {
                let v14 = min_u64(v9, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::safe_mul_div_u64(v13, v7, arg2));
                if (v14 > 0) {
                    let v15 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_bid_price(arg1, v11);
                    let v16 = v15;
                    assert!(v15 > 0, 3);
                    if (v5 > 0) {
                        v16 = apply_bid_penalty(v15, v5);
                    };
                    assert_bid_deviation<T0, T1>(arg0, v6, v16);
                    let v17 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::bid_remaining_notional_mut(arg1, v11);
                    *v17 = *v17 - 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::oracle::base_amount_to_usd_notional(v14, arg2, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::base_coin_decimals<T0, T1>(arg0));
                    v10 = v10 + 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::safe_mul_div_u64(v14, v16, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::get_one());
                    v9 = v9 - v14;
                    v12 = v16;
                };
            };
            v11 = v11 + 1;
        };
        if (v9 > 0) {
            let v18 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::safe_mul_div_u64(last_bid_bucket_step_notional(arg1), v7, arg2);
            let v19 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_bid_price(arg1, v8 - 1);
            assert!(v19 > 0, 3);
            while (v9 > 0) {
                let v20 = apply_bid_penalty(v19, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::bid_tail_penalty_bps<T0, T1>(arg0));
                v19 = v20;
                let v21 = if (v18 == 0) {
                    v9
                } else {
                    min_u64(v9, v18)
                };
                let v22 = v20;
                if (v5 > 0) {
                    v22 = apply_bid_penalty(v20, v5);
                };
                assert_bid_deviation<T0, T1>(arg0, v6, v22);
                v10 = v10 + 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::safe_mul_div_u64(v21, v22, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::get_one());
                v9 = v9 - v21;
                v12 = v22;
            };
        };
        (v10, v12, v4)
    }

    fun quote_sell_quote_with_prices<T0, T1>(arg0: &0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: &mut 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::RegimeState, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u64) {
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::assert_matching_regime<T0, T1>(arg0, arg1);
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::assert_trade_allowed<T0, T1>(arg0);
        let v0 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::oracle::quote_amount_to_usd_notional(arg5, arg3, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::quote_coin_decimals<T0, T1>(arg0));
        assert_trade_within_public_limit<T0, T1>(arg0, v0);
        let (v1, v2) = effective_mode<T0, T1>(arg0, arg1, arg4);
        assert_ask_allowed(v1);
        let v3 = if (v2) {
            0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::ask_penalty_bps<T0, T1>(arg0)
        } else {
            0
        };
        let v4 = projected_ask_flow_notional<T0, T1>(arg0, arg1, arg4, v0);
        let v5 = v3 + inventory_penalty_for_sell_quote<T0, T1>(arg0, arg2, arg3) + flow_penalty_for_ask<T0, T1>(arg0, v4);
        let v6 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::oracle::reference_price_from_usd(arg2, arg3, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::base_coin_decimals<T0, T1>(arg0), 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::quote_coin_decimals<T0, T1>(arg0));
        let v7 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_quote_one<T0, T1>(arg0);
        let v8 = (0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::bucket_count(arg1) as u64);
        assert!(v8 > 0, 1);
        let v9 = arg5;
        let v10 = 0;
        let v11 = 0;
        let v12 = 0;
        while (v11 < v8 && v9 > 0) {
            let v13 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_ask_remaining_notional(arg1, v11);
            if (v13 > 0) {
                let v14 = min_u64(v9, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::safe_mul_div_u64(v13, v7, arg3));
                if (v14 > 0) {
                    let v15 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_ask_price(arg1, v11);
                    let v16 = v15;
                    assert!(v15 > 0, 3);
                    if (v5 > 0) {
                        v16 = apply_ask_penalty(v15, v5);
                    };
                    assert_ask_deviation<T0, T1>(arg0, v6, v16);
                    let v17 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::ask_remaining_notional_mut(arg1, v11);
                    *v17 = *v17 - 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::oracle::quote_amount_to_usd_notional(v14, arg3, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::quote_coin_decimals<T0, T1>(arg0));
                    v10 = v10 + 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::safe_mul_div_u64(v14, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::get_one(), v16);
                    v9 = v9 - v14;
                    v12 = v16;
                };
            };
            v11 = v11 + 1;
        };
        if (v9 > 0) {
            let v18 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::safe_mul_div_u64(last_ask_bucket_step_notional(arg1), v7, arg3);
            let v19 = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_ask_price(arg1, v8 - 1);
            assert!(v19 > 0, 3);
            while (v9 > 0) {
                let v20 = apply_ask_penalty(v19, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::ask_tail_penalty_bps<T0, T1>(arg0));
                v19 = v20;
                let v21 = if (v18 == 0) {
                    v9
                } else {
                    min_u64(v9, v18)
                };
                let v22 = v20;
                if (v5 > 0) {
                    v22 = apply_ask_penalty(v20, v5);
                };
                assert_ask_deviation<T0, T1>(arg0, v6, v22);
                v10 = v10 + 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::safe_mul_div_u64(v21, 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::safe_math::get_one(), v22);
                v9 = v9 - v21;
                v12 = v22;
            };
        };
        (v10, v12, v4)
    }

    public fun swap_exact_in_base_pro<T0, T1>(arg0: &mut 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: &mut 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg4: &mut 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::assert_pool_version<T0, T1>(arg0);
        let (v0, v1, _) = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::oracle::current_market_prices<T0, T1>(arg0, arg3, arg2);
        swap_exact_in_base_with_prices<T0, T1>(arg0, arg1, v0, v1, 0x2::clock::timestamp_ms(arg2), arg4, arg5, arg6, arg7)
    }

    public(friend) fun swap_exact_in_base_with_prices<T0, T1>(arg0: &mut 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: &mut 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::RegimeState, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::coin::Coin<T0>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = quote_sell_base_with_prices<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        assert!(v0 >= arg7, 6);
        assert!(0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::quote_balance<T0, T1>(arg0) >= v0, 7);
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::base_coin_pay_in<T0, T1>(arg0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg5), arg6));
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::increase_trade_num<T0, T1>(arg0);
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::record_recent_bid_flow<T0, T1>(arg0, arg1, arg4, v2);
        let v3 = SwapEvent{
            pool_id                    : 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::pool_id<T0, T1>(arg0),
            is_sell_base               : true,
            amount_in                  : arg6,
            amount_out                 : v0,
            last_price                 : v1,
            base_usd_price             : arg2,
            quote_usd_price            : arg3,
            pool_base_balance          : 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::base_balance<T0, T1>(arg0),
            pool_quote_balance         : 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::quote_balance<T0, T1>(arg0),
            trade_num                  : 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::trade_num<T0, T1>(arg0),
            bid_remaining_notional_usd : 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_bid_remaining_notional_vec(arg1),
            ask_remaining_notional_usd : 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_ask_remaining_notional_vec(arg1),
        };
        0x2::event::emit<SwapEvent>(v3);
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::quote_coin_pay_out<T0, T1>(arg0, v0, arg8)
    }

    public fun swap_exact_in_quote_pro<T0, T1>(arg0: &mut 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: &mut 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::RegimeState, arg2: &0x2::clock::Clock, arg3: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg4: &mut 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::assert_pool_version<T0, T1>(arg0);
        let (v0, v1, _) = 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::oracle::current_market_prices<T0, T1>(arg0, arg3, arg2);
        swap_exact_in_quote_with_prices<T0, T1>(arg0, arg1, v0, v1, 0x2::clock::timestamp_ms(arg2), arg4, arg5, arg6, arg7)
    }

    public(friend) fun swap_exact_in_quote_with_prices<T0, T1>(arg0: &mut 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::PoolState<T0, T1>, arg1: &mut 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::RegimeState, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = quote_sell_quote_with_prices<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        assert!(v0 >= arg7, 6);
        assert!(0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::base_balance<T0, T1>(arg0) >= v0, 7);
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::quote_coin_pay_in<T0, T1>(arg0, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg5), arg6));
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::increase_trade_num<T0, T1>(arg0);
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::record_recent_ask_flow<T0, T1>(arg0, arg1, arg4, v2);
        let v3 = SwapEvent{
            pool_id                    : 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::pool_id<T0, T1>(arg0),
            is_sell_base               : false,
            amount_in                  : arg6,
            amount_out                 : v0,
            last_price                 : v1,
            base_usd_price             : arg2,
            quote_usd_price            : arg3,
            pool_base_balance          : 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::base_balance<T0, T1>(arg0),
            pool_quote_balance         : 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::quote_balance<T0, T1>(arg0),
            trade_num                  : 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::trade_num<T0, T1>(arg0),
            bid_remaining_notional_usd : 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_bid_remaining_notional_vec(arg1),
            ask_remaining_notional_usd : 0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::get_ask_remaining_notional_vec(arg1),
        };
        0x2::event::emit<SwapEvent>(v3);
        0x8667102da01d5cfc29017138d658d40ec593b1a97f49228a930ea3d872092bbb::pool::base_coin_pay_out<T0, T1>(arg0, v0, arg8)
    }

    // decompiled from Move bytecode v7
}

