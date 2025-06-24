module 0xbdc8096f4cfba2e0ff86edd6c79359e2951c482c8e49e24b07e4832c98a0f3dc::dex_cetus {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        sqrt_price_current: u128,
        liquidity: u128,
        tick_current: u32,
        fee_rate: u32,
        protocol_fee_rate: u32,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
    }

    fun calculate_delta_sqrt_price_from_input(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u128 {
        if (arg3) {
            arg0 * arg2 * 18446744073709551616 / (arg1 * 18446744073709551616 + arg0 * arg2)
        } else {
            arg0 * 18446744073709551616 / arg1
        }
    }

    fun calculate_output_from_delta_sqrt_price(arg0: u128, arg1: u128, arg2: bool) : u128 {
        if (arg2) {
            arg1 * arg0 / 18446744073709551616
        } else {
            arg1 * arg0 / 18446744073709551616
        }
    }

    public fun get_pool_info<T0, T1>(arg0: &Pool<T0, T1>) : (u128, u128, u32) {
        (arg0.sqrt_price_current, arg0.liquidity, arg0.tick_current)
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b))
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg2 > 0, 3);
        let v0 = arg0.sqrt_price_current;
        let v1 = arg0.liquidity;
        let v2 = calculate_delta_sqrt_price_from_input((arg2 as u128) - (arg2 as u128) * (arg0.fee_rate as u128) / (1000000 as u128), v1, v0, true);
        let v3 = (calculate_output_from_delta_sqrt_price(v2, v1, true) as u64);
        assert!(v3 >= arg3, 2);
        assert!(v3 <= 0x2::balance::value<T1>(&arg0.balance_b), 1);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        arg0.sqrt_price_current = v0 - v2;
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, v3), arg5)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 > 0, 3);
        let v0 = arg0.sqrt_price_current;
        let v1 = arg0.liquidity;
        let v2 = calculate_delta_sqrt_price_from_input((arg2 as u128) - (arg2 as u128) * (arg0.fee_rate as u128) / (1000000 as u128), v1, v0, false);
        let v3 = (calculate_output_from_delta_sqrt_price(v2, v1, false) as u64);
        assert!(v3 >= arg3, 2);
        assert!(v3 <= 0x2::balance::value<T0>(&arg0.balance_a), 1);
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg1));
        arg0.sqrt_price_current = v0 + v2;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, v3), arg5)
    }

    // decompiled from Move bytecode v6
}

