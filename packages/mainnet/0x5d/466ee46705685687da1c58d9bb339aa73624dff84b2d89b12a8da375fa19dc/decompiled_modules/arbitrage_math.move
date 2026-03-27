module 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::arbitrage_math {
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

    fun calculate_conditional_cost(arg0: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>, arg1: u64) : u128 {
        let v0 = 0;
        let v1 = v0;
        let v2 = (arg1 as u128);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg0)) {
            let (v4, v5) = 0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::get_reserves(0x1::vector::borrow<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg0, v3));
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

    public fun calculate_spot_arbitrage_profit<T0, T1, T2>(arg0: &0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>, arg2: u64, arg3: bool) : u128 {
        if (arg3) {
            simulate_spot_to_conditional_profit<T0, T1, T2>(arg0, arg1, arg2)
        } else {
            simulate_conditional_to_spot_profit<T0, T1, T2>(arg0, arg1, arg2)
        }
    }

    fun calculate_spot_revenue(arg0: u64, arg1: u64, arg2: u64) : u128 {
        let v0 = (arg2 as u256);
        let v1 = (arg0 as u256) + v0;
        if (v1 == 0) {
            return 0
        };
        let v2 = (arg1 as u256) * v0 / v1;
        if (v2 > 340282366920938463463374607431768211455) {
            340282366920938463463374607431768211455
        } else {
            (v2 as u128)
        }
    }

    fun classify_spot_position<T0, T1, T2>(arg0: &0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>) : (bool, bool) {
        let v0 = 0x1::vector::length<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg1);
        if (v0 == 0) {
            return (false, false)
        };
        let (v1, v2) = 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::get_reserves<T0, T1, T2>(arg0);
        if (v1 == 0 || v2 == 0) {
            return (false, false)
        };
        let v3 = true;
        let v4 = true;
        let v5 = 0;
        while (v5 < v0) {
            let (v6, v7) = 0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::get_reserves(0x1::vector::borrow<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg1, v5));
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

    fun compute_conditional_to_spot<T0, T1, T2>(arg0: &0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>, arg2: u64) : (u64, u128) {
        let v0 = 0x1::vector::length<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg1);
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = 18446744073709551615;
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            let (v4, v5) = 0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::get_reserves(0x1::vector::borrow<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg1, v3));
            if (v4 == 0 || v5 == 0) {
                return (0, 0)
            };
            if (v4 < v1) {
                v2 = v4;
            };
            v3 = v3 + 1;
        };
        let (v6, v7) = 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::get_reserves<T0, T1, T2>(arg0);
        if (v6 == 0 || v7 == 0) {
            return (0, 0)
        };
        if (early_exit_cond_to_spot(v6, v7, arg1)) {
            return (0, 0)
        };
        if (v2 < 2) {
            return (0, 0)
        };
        ternary_search_cond_to_spot(v6, v7, arg1, apply_smart_bound(v2 - 1, arg2))
    }

    public fun compute_optimal_arbitrage<T0, T1, T2>(arg0: &0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>, arg2: u64) : (u64, u8, u128) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = 0x1::vector::length<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg1);
        if (v4 > 0) {
            assert!(v4 <= 0xcc850ba260a5e370a0e98b96db02037f6b84893754b6c6c198f3e4f24feea81e::constants::protocol_max_outcomes(), 0);
        };
        let (v5, v6) = classify_spot_position<T0, T1, T2>(arg0, arg1);
        if (!v5 && !v6) {
            return (0, 0, 0)
        };
        if (v4 > 0 && v6) {
            let (v7, v8) = compute_spot_to_conditional<T0, T1, T2>(arg0, arg1, arg2);
            if (v8 > v2) {
                v3 = v8;
                v0 = v7;
                v1 = 1;
            };
        };
        if (v4 > 0 && v5) {
            let (v9, v10) = compute_conditional_to_spot<T0, T1, T2>(arg0, arg1, arg2);
            if (v10 > v3) {
                v3 = v10;
                v0 = v9;
                v1 = 2;
            };
        };
        (v0, v1, v3)
    }

    public fun compute_optimal_arbitrage_for_n_outcomes<T0, T1, T2>(arg0: &0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>, arg2: u64) : (u64, u128, bool) {
        let (v0, v1, v2) = compute_optimal_arbitrage<T0, T1, T2>(arg0, arg1, arg2);
        (v0, v2, v1 == 2)
    }

    public fun compute_optimal_conditional_to_spot<T0, T1, T2>(arg0: &0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>, arg2: u64) : (u64, u128) {
        compute_conditional_to_spot<T0, T1, T2>(arg0, arg1, arg2)
    }

    public fun compute_optimal_spot_to_conditional<T0, T1, T2>(arg0: &0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>, arg2: u64) : (u64, u128) {
        compute_spot_to_conditional<T0, T1, T2>(arg0, arg1, arg2)
    }

    fun compute_spot_to_conditional<T0, T1, T2>(arg0: &0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>, arg2: u64) : (u64, u128) {
        let v0 = 0x1::vector::length<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg1);
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = 0;
        while (v1 < v0) {
            let (v2, v3) = 0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::get_reserves(0x1::vector::borrow<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg1, v1));
            if (v2 == 0 || v3 == 0) {
                return (0, 0)
            };
            v1 = v1 + 1;
        };
        let (v4, v5) = 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::get_reserves<T0, T1, T2>(arg0);
        if (v4 == 0 || v5 == 0) {
            return (0, 0)
        };
        v1 = 0;
        while (v1 < v0) {
            let (v6, v7) = 0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::get_reserves(0x1::vector::borrow<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg1, v1));
            if ((v5 as u256) * (v6 as u256) >= (v7 as u256) * (v4 as u256)) {
                return (0, 0)
            };
            v1 = v1 + 1;
        };
        if (v4 < 2) {
            return (0, 0)
        };
        ternary_search_spot_to_cond(v4, v5, arg1, apply_smart_bound(v4 - 1, arg2))
    }

    fun early_exit_cond_to_spot(arg0: u64, arg1: u64, arg2: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg2)) {
            let (v1, v2) = 0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::get_reserves(0x1::vector::borrow<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg2, v0));
            if ((arg1 as u256) * (v1 as u256) <= (v2 as u256) * (arg0 as u256)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun profit_cond_to_spot(arg0: u64, arg1: u64, arg2: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>, arg3: u64) : u128 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = calculate_spot_revenue(arg0, arg1, arg3);
        let v1 = calculate_conditional_cost(arg2, arg3);
        if (v1 == 340282366920938463463374607431768211455) {
            return 0
        };
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    fun profit_spot_to_cond(arg0: u64, arg1: u64, arg2: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>, arg3: u64) : u128 {
        if (arg3 == 0) {
            return 0
        };
        if (arg3 >= arg0) {
            return 0
        };
        let v0 = ((arg0 - arg3) as u128);
        if (v0 == 0) {
            return 0
        };
        let v1 = ((arg1 as u128) * (arg3 as u128) + v0 - 1) / v0;
        let v2 = 340282366920938463463374607431768211455;
        let v3 = v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg2)) {
            let (v5, v6) = 0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::get_reserves(0x1::vector::borrow<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg2, v4));
            let v7 = (v5 as u128) + (arg3 as u128);
            if (v7 == 0) {
                return 0
            };
            let v8 = (v6 as u128) * (arg3 as u128) / v7;
            if (v8 < v2) {
                v3 = v8;
            };
            v4 = v4 + 1;
        };
        if (v3 == 340282366920938463463374607431768211455) {
            return 0
        };
        if (v3 > v1) {
            v3 - v1
        } else {
            0
        }
    }

    public fun route_cond_to_spot() : u8 {
        2
    }

    public fun route_none() : u8 {
        0
    }

    public fun route_spot_to_cond() : u8 {
        1
    }

    public fun simulate_conditional_to_spot_profit<T0, T1, T2>(arg0: &0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>, arg2: u64) : u128 {
        if (0x1::vector::length<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg1) == 0) {
            return 0
        };
        let (v0, v1) = 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::get_reserves<T0, T1, T2>(arg0);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        let v2 = calculate_conditional_cost(arg1, arg2);
        if (v2 == 340282366920938463463374607431768211455) {
            return 0
        };
        let v3 = calculate_spot_revenue(v0, v1, arg2);
        if (v3 > v2) {
            v3 - v2
        } else {
            0
        }
    }

    fun simulate_spot_to_conditional_profit<T0, T1, T2>(arg0: &0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::UnifiedSpotPool<T0, T1, T2>, arg1: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>, arg2: u64) : u128 {
        let v0 = 0x1::vector::length<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg1);
        if (v0 == 0 || arg2 == 0) {
            return 0
        };
        let (v1, v2) = 0x5d466ee46705685687da1c58d9bb339aa73624dff84b2d89b12a8da375fa19dc::unified_spot_pool::get_reserves<T0, T1, T2>(arg0);
        if (v1 == 0 || v2 == 0) {
            return 0
        };
        if (arg2 >= v1) {
            return 0
        };
        let v3 = ((v1 - arg2) as u128);
        if (v3 == 0) {
            return 0
        };
        let v4 = ((v2 as u128) * (arg2 as u128) + v3 - 1) / v3;
        let v5 = 340282366920938463463374607431768211455;
        let v6 = v5;
        let v7 = 0;
        while (v7 < v0) {
            let (v8, v9) = 0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::get_reserves(0x1::vector::borrow<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>(arg1, v7));
            let v10 = (v8 as u128) + (arg2 as u128);
            if (v10 == 0) {
                return 0
            };
            let v11 = (v9 as u128) * (arg2 as u128) / v10;
            if (v11 < v5) {
                v6 = v11;
            };
            v7 = v7 + 1;
        };
        if (v6 == 340282366920938463463374607431768211455) {
            return 0
        };
        if (v6 > v4) {
            v6 - v4
        } else {
            0
        }
    }

    fun ternary_search_cond_to_spot(arg0: u64, arg1: u64, arg2: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>, arg3: u64) : (u64, u128) {
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
            let v8 = profit_cond_to_spot(arg0, arg1, arg2, v6);
            let v9 = profit_cond_to_spot(arg0, arg1, arg2, v7);
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
            let v11 = profit_cond_to_spot(arg0, arg1, arg2, v10);
            if (v11 > v4) {
                v4 = v11;
                v2 = v10;
            };
            v10 = v10 + 1;
        };
        (v2, v4)
    }

    fun ternary_search_spot_to_cond(arg0: u64, arg1: u64, arg2: &vector<0x27251e34753ea8bbbf3013f237b08a28a4b8289d1d2aac6316a6f13906588e55::conditional_amm::LiquidityPool>, arg3: u64) : (u64, u128) {
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
            let v8 = profit_spot_to_cond(arg0, arg1, arg2, v6);
            let v9 = profit_spot_to_cond(arg0, arg1, arg2, v7);
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
            let v11 = profit_spot_to_cond(arg0, arg1, arg2, v10);
            if (v11 > v4) {
                v4 = v11;
                v2 = v10;
            };
            v10 = v10 + 1;
        };
        (v2, v4)
    }

    // decompiled from Move bytecode v6
}

