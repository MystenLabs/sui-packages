module 0x338f8c32949f54f51c2e3f286e9315fa684ecc1fc0b8975e601a4b2953b9cd40::dex_cetus {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        liquidity: u128,
        current_sqrt_price: u128,
        current_tick_index: u32,
        fee_rate: u64,
        protocol_fee_rate: u64,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        tick_spacing: u32,
        cumulative_volume_a: u128,
        cumulative_volume_b: u128,
        last_update_time: u64,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        pool_id: address,
        tick_lower: u32,
        tick_upper: u32,
        liquidity: u128,
        fee_growth_inside_a: u128,
        fee_growth_inside_b: u128,
        tokens_owed_a: u64,
        tokens_owed_b: u64,
    }

    public fun calculate_price_impact<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool, arg3: u128) : u64 {
        let v0 = arg0.current_sqrt_price;
        if (arg2) {
            let (v2, v3) = get_reserves<T0, T1>(arg0);
            let v4 = v0 * v0 / 1000000000000000000;
            let v5 = (v2 as u128) + (arg1 as u128);
            let v6 = (v3 as u128) - (calculate_swap_output_a_to_b<T0, T1>(arg0, arg1, arg3) as u128);
            if (v5 > 0 && v6 > 0) {
                let v7 = v6 * 1000000000000000000 / v5;
                if (v4 > v7) {
                    (((v4 - v7) * (1000000 as u128) / v4) as u64)
                } else {
                    0
                }
            } else {
                0
            }
        } else {
            let (v8, v9) = get_reserves<T0, T1>(arg0);
            let v10 = v0 * v0 / 1000000000000000000;
            let v11 = (v8 as u128) - (calculate_swap_output_b_to_a<T0, T1>(arg0, arg1, arg3) as u128);
            let v12 = (v9 as u128) + (arg1 as u128);
            if (v11 > 0 && v12 > 0) {
                let v13 = v12 * 1000000000000000000 / v11;
                if (v13 > v10) {
                    (((v13 - v10) * (1000000 as u128) / v10) as u64)
                } else {
                    0
                }
            } else {
                0
            }
        }
    }

    fun calculate_swap_output_a_to_b<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u128) : u64 {
        let v0 = arg0.current_sqrt_price;
        let v1 = arg0.liquidity;
        let v2 = (arg1 as u128);
        let v3 = v2 * v0 * v1 / (v1 * 1000000000000000000 + v2 * v0);
        let v4 = if (arg2 > 0) {
            let v5 = arg2 * v2 / 1000000000000000000;
            if (v3 < v5) {
                v3
            } else {
                v5
            }
        } else {
            v3
        };
        (v4 as u64)
    }

    fun calculate_swap_output_b_to_a<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u128) : u64 {
        let v0 = arg0.liquidity;
        let v1 = (arg1 as u128);
        let v2 = v1 * v0 * 1000000000000000000 / (arg0.current_sqrt_price * v0 + v1 * 1000000000000000000);
        let v3 = if (arg2 > 0) {
            let v4 = v1 * 1000000000000000000 / arg2;
            if (v2 < v4) {
                v2
            } else {
                v4
            }
        } else {
            v2
        };
        (v3 as u64)
    }

    public fun get_liquidity<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.liquidity
    }

    public fun get_pool_metadata<T0, T1>(arg0: &Pool<T0, T1>) : (u128, u128, u32, u64) {
        (arg0.liquidity, arg0.current_sqrt_price, arg0.current_tick_index, arg0.fee_rate)
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b))
    }

    public fun get_sqrt_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.current_sqrt_price
    }

    public fun get_tick_index<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        arg0.current_tick_index
    }

    fun sqrt_u128(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg2 > 0, 3);
        assert!(arg0.liquidity > 0, 1);
        let v0 = 0x2::balance::value<T1>(&arg0.reserve_b);
        assert!(0x2::balance::value<T0>(&arg0.reserve_a) > 0 && v0 > 0, 1);
        let v1 = arg2 - arg2 * arg0.fee_rate / 1000000;
        let v2 = calculate_swap_output_a_to_b<T0, T1>(arg0, v1, arg4);
        assert!(v2 >= arg3, 2);
        assert!(v2 < v0, 1);
        update_pool_state_a_to_b<T0, T1>(arg0, v1, v2);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        arg0.cumulative_volume_a = arg0.cumulative_volume_a + (arg2 as u128);
        arg0.last_update_time = 0x2::clock::timestamp_ms(arg5);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v2), arg6)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 > 0, 3);
        assert!(arg0.liquidity > 0, 1);
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_a);
        assert!(v0 > 0 && 0x2::balance::value<T1>(&arg0.reserve_b) > 0, 1);
        let v1 = arg2 - arg2 * arg0.fee_rate / 1000000;
        let v2 = calculate_swap_output_b_to_a<T0, T1>(arg0, v1, arg4);
        assert!(v2 >= arg3, 2);
        assert!(v2 < v0, 1);
        update_pool_state_b_to_a<T0, T1>(arg0, v1, v2);
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg1));
        arg0.cumulative_volume_b = arg0.cumulative_volume_b + (arg2 as u128);
        arg0.last_update_time = 0x2::clock::timestamp_ms(arg5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v2), arg6)
    }

    fun update_pool_state_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_a) + arg1;
        let v1 = 0x2::balance::value<T1>(&arg0.reserve_b) - arg2;
        if (v0 > 0 && v1 > 0) {
            arg0.current_sqrt_price = sqrt_u128((v1 as u128) * 1000000000000000000 / (v0 as u128));
        };
    }

    fun update_pool_state_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) {
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_a) - arg2;
        let v1 = 0x2::balance::value<T1>(&arg0.reserve_b) + arg1;
        if (v0 > 0 && v1 > 0) {
            arg0.current_sqrt_price = sqrt_u128((v1 as u128) * 1000000000000000000 / (v0 as u128));
        };
    }

    // decompiled from Move bytecode v6
}

