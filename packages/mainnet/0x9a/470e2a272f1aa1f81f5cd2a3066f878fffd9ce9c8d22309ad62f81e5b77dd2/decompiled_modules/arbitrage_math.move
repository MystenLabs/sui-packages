module 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::arbitrage_math {
    fun amount_after_conditional_fees(arg0: &0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool, arg1: u64) : u64 {
        let v0 = 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::math::mul_div_to_64(arg1, 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::protocol_fee_bps(), 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::total_fee_bps()) + 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::math::mul_div_to_64(arg1, 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::get_fee_bps(arg0), 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::total_fee_bps());
        if (arg1 <= v0) {
            0
        } else {
            arg1 - v0
        }
    }

    fun apply_smart_bound(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        let v0 = if (arg1 > 18446744073709551615 / 11) {
            18446744073709551615
        } else {
            arg1 * 11 / 10
        };
        if (v0 < arg0) {
            v0
        } else {
            arg0
        }
    }

    fun calculate_conditional_cost(arg0: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg1: u64) : u128 {
        let v0 = 0;
        let v1 = v0;
        let v2 = (arg1 as u128);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg0)) {
            let (v4, v5) = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::get_reserves(0x1::vector::borrow<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg0, v3));
            if (arg1 >= v4) {
                return 340282366920938463463374607431768211455
            };
            let v6 = (v4 as u128) - v2;
            if (v6 == 0) {
                return 340282366920938463463374607431768211455
            };
            let v7 = ((v5 as u128) * v2 + v6 - 1) / v6;
            if (v7 > v0) {
                v1 = v7;
            };
            v3 = v3 + 1;
        };
        v1
    }

    fun classify_spot_position<T0, T1, T2>(arg0: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>) : (bool, bool) {
        let v0 = 0x1::vector::length<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg1);
        if (v0 == 0) {
            return (false, false)
        };
        let (v1, v2) = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::get_reserves<T0, T1, T2>(arg0);
        if (v1 == 0 || v2 == 0) {
            return (false, false)
        };
        let v3 = true;
        let v4 = true;
        let v5 = 0;
        while (v5 < v0) {
            let (v6, v7) = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::get_reserves(0x1::vector::borrow<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg1, v5));
            if (v6 == 0 || v7 == 0) {
                return (false, false)
            };
            let v8 = (v2 as u256) * (v6 as u256);
            let v9 = (v7 as u256) * (v1 as u256);
            if (v8 <= v9) {
                v3 = false;
            };
            if (v8 >= v9) {
                v4 = false;
            };
            if (!v3 && !v4) {
                return (false, false)
            };
            v5 = v5 + 1;
        };
        (v3, v4)
    }

    public fun compute_best_asset_to_stable_split<T0, T1, T2>(arg0: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (u64, u64, u64) {
        if (arg2 == 0) {
            return (0, 0, 0)
        };
        let v0 = 0x1::vector::length<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg1);
        if (v0 > 0) {
            assert!(v0 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::protocol_max_outcomes(), 0);
        };
        if (v0 == 0 || arg3 == 0) {
            return (arg2, 0, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::simulate_swap_asset_to_stable_accurate<T0, T1, T2>(arg0, arg2, arg4))
        };
        ternary_search_asset_to_stable_split<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun compute_best_stable_to_asset_split<T0, T1, T2>(arg0: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (u64, u64, u64) {
        if (arg2 == 0) {
            return (0, 0, 0)
        };
        let v0 = 0x1::vector::length<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg1);
        if (v0 > 0) {
            assert!(v0 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::protocol_max_outcomes(), 0);
        };
        if (v0 == 0 || arg3 == 0) {
            return (arg2, 0, 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::simulate_swap_stable_to_asset_accurate<T0, T1, T2>(arg0, arg2, arg4))
        };
        ternary_search_stable_to_asset_split<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4)
    }

    fun compute_internal_conditional_to_spot(arg0: u64, arg1: u64, arg2: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg3: u64) : (u64, u128) {
        let v0 = 0x1::vector::length<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg2);
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = 18446744073709551615;
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            let (v4, v5) = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::get_reserves(0x1::vector::borrow<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg2, v3));
            if (v4 == 0 || v5 == 0) {
                return (0, 0)
            };
            if (v4 < v1) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        if (v2 < 2) {
            return (0, 0)
        };
        ternary_search_internal_cond_to_spot(arg0, arg1, arg2, apply_smart_bound(v2 - 1, arg3))
    }

    fun compute_internal_spot_to_conditional(arg0: u64, arg1: u64, arg2: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg3: u64) : (u64, u128) {
        if (arg0 < 2) {
            return (0, 0)
        };
        ternary_search_internal_spot_to_cond(arg0, arg1, arg2, apply_smart_bound(arg0 - 1, arg3))
    }

    public fun compute_optimal_internal_rebalance<T0, T1, T2>(arg0: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg2: u64) : (u64, bool, u128) {
        let v0 = 0x1::vector::length<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg1);
        if (v0 > 0) {
            assert!(v0 <= 0x8085d42c3f597247c761e0a15e56d201a6e9727f2dff5a1d794491416b5ce82f::constants::protocol_max_outcomes(), 0);
        };
        let (v1, v2) = classify_spot_position<T0, T1, T2>(arg0, arg1);
        if (!v1 && !v2) {
            return (0, false, 0)
        };
        let (v3, v4) = 0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::get_reserves<T0, T1, T2>(arg0);
        if (v3 == 0 || v4 == 0) {
            return (0, false, 0)
        };
        if (v2) {
            let (v5, v6) = compute_internal_spot_to_conditional(v3, v4, arg1, arg2);
            if (v6 > 0) {
                return (v5, false, v6)
            };
        };
        if (v1) {
            let (v7, v8) = compute_internal_conditional_to_spot(v3, v4, arg1, arg2);
            if (v8 > 0) {
                return (v7, true, v8)
            };
        };
        (0, false, 0)
    }

    fun internal_score_cond_to_spot(arg0: u64, arg1: u64, arg2: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg3: u64) : u128 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = calculate_conditional_cost(arg2, arg3);
        if (v0 == 340282366920938463463374607431768211455) {
            return 0
        };
        if (v0 == 0 || v0 >= (arg1 as u128)) {
            return 0
        };
        if (v0 > 18446744073709551615) {
            return 0
        };
        let v1 = (v0 as u64);
        let v2 = min_conditional_asset_out(arg2, v1);
        if (v2 == 0) {
            return 0
        };
        k_gain_to_u128((arg0 as u256) * (arg1 as u256), ((arg0 as u256) + (v2 as u256)) * ((arg1 - v1) as u256))
    }

    fun internal_score_spot_to_cond(arg0: u64, arg1: u64, arg2: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg3: u64) : u128 {
        if (arg3 == 0 || arg3 >= arg0) {
            return 0
        };
        let v0 = min_conditional_stable_out(arg2, arg3);
        if (v0 == 0) {
            return 0
        };
        k_gain_to_u128((arg0 as u256) * (arg1 as u256), ((arg0 - arg3) as u256) * ((arg1 as u256) + (v0 as u256)))
    }

    fun k_gain_to_u128(arg0: u256, arg1: u256) : u128 {
        if (arg1 <= arg0) {
            return 0
        };
        let v0 = arg1 - arg0;
        if (v0 > 340282366920938463463374607431768211455) {
            340282366920938463463374607431768211455
        } else {
            (v0 as u128)
        }
    }

    public(friend) fun max_conditional_stable_cost(arg0: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg1: u64) : u128 {
        calculate_conditional_cost(arg0, arg1)
    }

    fun min_conditional_asset_out(arg0: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg1: u64) : u128 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x1::vector::length<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = 340282366920938463463374607431768211455;
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            let (v4, v5) = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::get_reserves(0x1::vector::borrow<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg0, v3));
            if (v4 == 0 || v5 == 0) {
                return 0
            };
            let v6 = (v5 as u128) + (arg1 as u128);
            if (v6 == 0) {
                return 0
            };
            let v7 = (v4 as u128) * (arg1 as u128) / v6;
            if (v7 < v1) {
                v2 = v7;
            };
            v3 = v3 + 1;
        };
        if (v2 == 340282366920938463463374607431768211455) {
            0
        } else {
            v2
        }
    }

    fun min_conditional_asset_out_with_fees(arg0: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg1: u64) : u128 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x1::vector::length<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = 340282366920938463463374607431768211455;
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg0, v3);
            let v5 = amount_after_conditional_fees(v4, arg1);
            if (v5 == 0) {
                return 0
            };
            let (v6, v7) = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::get_reserves(v4);
            if (v6 == 0 || v7 == 0) {
                return 0
            };
            let v8 = (v7 as u128) + (v5 as u128);
            if (v8 == 0) {
                return 0
            };
            let v9 = (v6 as u128) * (v5 as u128) / v8;
            if (v9 < v1) {
                v2 = v9;
            };
            v3 = v3 + 1;
        };
        if (v2 == 340282366920938463463374607431768211455) {
            0
        } else {
            v2
        }
    }

    fun min_conditional_stable_out(arg0: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg1: u64) : u128 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x1::vector::length<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = 340282366920938463463374607431768211455;
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            let (v4, v5) = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::get_reserves(0x1::vector::borrow<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg0, v3));
            if (v4 == 0 || v5 == 0) {
                return 0
            };
            let v6 = (v4 as u128) + (arg1 as u128);
            if (v6 == 0) {
                return 0
            };
            let v7 = (v5 as u128) * (arg1 as u128) / v6;
            if (v7 < v1) {
                v2 = v7;
            };
            v3 = v3 + 1;
        };
        if (v2 == 340282366920938463463374607431768211455) {
            0
        } else {
            v2
        }
    }

    fun min_conditional_stable_out_with_fees(arg0: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg1: u64) : u128 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = 0x1::vector::length<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = 340282366920938463463374607431768211455;
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>(arg0, v3);
            let v5 = amount_after_conditional_fees(v4, arg1);
            if (v5 == 0) {
                return 0
            };
            let (v6, v7) = 0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::get_reserves(v4);
            if (v6 == 0 || v7 == 0) {
                return 0
            };
            let v8 = (v6 as u128) + (v5 as u128);
            if (v8 == 0) {
                return 0
            };
            let v9 = (v7 as u128) * (v5 as u128) / v8;
            if (v9 < v1) {
                v2 = v9;
            };
            v3 = v3 + 1;
        };
        if (v2 == 340282366920938463463374607431768211455) {
            0
        } else {
            v2
        }
    }

    public(friend) fun quote_conditional_asset_to_stable(arg0: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg1: u64) : u64 {
        let v0 = min_conditional_stable_out_with_fees(arg0, arg1);
        if (v0 > 18446744073709551615) {
            0
        } else {
            (v0 as u64)
        }
    }

    public(friend) fun quote_conditional_stable_to_asset(arg0: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg1: u64) : u64 {
        let v0 = min_conditional_asset_out_with_fees(arg0, arg1);
        if (v0 > 18446744073709551615) {
            0
        } else {
            (v0 as u64)
        }
    }

    fun split_score<T0, T1, T2>(arg0: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) : u128 {
        if (arg3 > arg2) {
            return 0
        };
        let v0 = arg2 - arg3;
        let v1 = if (v0 == 0) {
            0
        } else if (arg5) {
            0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::simulate_swap_stable_to_asset_accurate<T0, T1, T2>(arg0, v0, arg6)
        } else {
            0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::simulate_swap_asset_to_stable_accurate<T0, T1, T2>(arg0, v0, arg6)
        };
        if (v0 > 0 && v1 == 0) {
            return 0
        };
        let v2 = if (arg3 == 0) {
            0
        } else if (arg5) {
            quote_conditional_stable_to_asset(arg1, arg3)
        } else {
            quote_conditional_asset_to_stable(arg1, arg3)
        };
        if (arg3 > 0 && v2 == 0) {
            return 0
        };
        if (v2 > arg4) {
            return 0
        };
        let v3 = (v1 as u128) + (v2 as u128);
        if (v3 > 18446744073709551615) {
            return 0
        };
        v3
    }

    fun ternary_search_asset_to_stable_split<T0, T1, T2>(arg0: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (u64, u64, u64) {
        ternary_search_split<T0, T1, T2>(arg0, arg1, arg2, arg3, false, arg4)
    }

    fun ternary_search_internal_cond_to_spot(arg0: u64, arg1: u64, arg2: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg3: u64) : (u64, u128) {
        if (arg3 == 0) {
            return (0, 0)
        };
        let v0 = 0;
        let v1 = arg3;
        let v2 = 0;
        let v3 = 0;
        let v4 = v3;
        while (v1 - v0 > 3) {
            let v5 = (v1 - v0) / 3;
            let v6 = v0 + v5;
            let v7 = v1 - v5;
            let v8 = internal_score_cond_to_spot(arg0, arg1, arg2, v6);
            let v9 = internal_score_cond_to_spot(arg0, arg1, arg2, v7);
            if (v8 > v3) {
                v4 = v8;
                v2 = v6;
            };
            if (v9 > v4) {
                v4 = v9;
                v2 = v7;
            };
            if (v8 >= v9) {
                v1 = v7;
                continue
            };
            v0 = v6;
        };
        let v10 = v0;
        while (v10 <= v1) {
            let v11 = internal_score_cond_to_spot(arg0, arg1, arg2, v10);
            if (v11 > v4) {
                v4 = v11;
                v2 = v10;
            };
            v10 = v10 + 1;
        };
        (v2, v4)
    }

    fun ternary_search_internal_spot_to_cond(arg0: u64, arg1: u64, arg2: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg3: u64) : (u64, u128) {
        if (arg3 == 0) {
            return (0, 0)
        };
        let v0 = 0;
        let v1 = arg3;
        let v2 = 0;
        let v3 = 0;
        let v4 = v3;
        while (v1 - v0 > 3) {
            let v5 = (v1 - v0) / 3;
            let v6 = v0 + v5;
            let v7 = v1 - v5;
            let v8 = internal_score_spot_to_cond(arg0, arg1, arg2, v6);
            let v9 = internal_score_spot_to_cond(arg0, arg1, arg2, v7);
            if (v8 > v3) {
                v4 = v8;
                v2 = v6;
            };
            if (v9 > v4) {
                v4 = v9;
                v2 = v7;
            };
            if (v8 >= v9) {
                v1 = v7;
                continue
            };
            v0 = v6;
        };
        let v10 = v0;
        while (v10 <= v1) {
            let v11 = internal_score_spot_to_cond(arg0, arg1, arg2, v10);
            if (v11 > v4) {
                v4 = v11;
                v2 = v10;
            };
            v10 = v10 + 1;
        };
        (v2, v4)
    }

    fun ternary_search_split<T0, T1, T2>(arg0: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = 0;
        let v1 = arg2;
        let v2 = 0;
        let v3 = split_score<T0, T1, T2>(arg0, arg1, arg2, 0, arg3, arg4, arg5);
        let v4 = v3;
        let v5 = split_score<T0, T1, T2>(arg0, arg1, arg2, arg2, arg3, arg4, arg5);
        if (v5 > v3) {
            v4 = v5;
            v2 = arg2;
        };
        while (v1 - v0 > 3) {
            let v6 = (v1 - v0) / 3;
            let v7 = v0 + v6;
            let v8 = v1 - v6;
            let v9 = split_score<T0, T1, T2>(arg0, arg1, arg2, v7, arg3, arg4, arg5);
            let v10 = split_score<T0, T1, T2>(arg0, arg1, arg2, v8, arg3, arg4, arg5);
            if (v9 > v4) {
                v4 = v9;
                v2 = v7;
            };
            if (v10 > v4) {
                v4 = v10;
                v2 = v8;
            };
            if (v9 >= v10) {
                v1 = v8;
                continue
            };
            v0 = v7;
        };
        let v11 = v0;
        while (v11 <= v1) {
            let v12 = split_score<T0, T1, T2>(arg0, arg1, arg2, v11, arg3, arg4, arg5);
            if (v12 > v4) {
                v4 = v12;
                v2 = v11;
            };
            if (v11 == v1) {
                break
            };
            v11 = v11 + 1;
        };
        (arg2 - v2, v2, u128_to_u64_quote(v4))
    }

    fun ternary_search_stable_to_asset_split<T0, T1, T2>(arg0: &0x9a470e2a272f1aa1f81f5cd2a3066f878fffd9ce9c8d22309ad62f81e5b77dd2::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x844fcce6ab4bbfb44b09431b0f07765d671d2aee3122f578b15b2402c2033781::conditional_amm::LiquidityPool>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (u64, u64, u64) {
        ternary_search_split<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg4)
    }

    fun u128_to_u64_quote(arg0: u128) : u64 {
        if (arg0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (arg0 as u64)
        }
    }

    // decompiled from Move bytecode v6
}

