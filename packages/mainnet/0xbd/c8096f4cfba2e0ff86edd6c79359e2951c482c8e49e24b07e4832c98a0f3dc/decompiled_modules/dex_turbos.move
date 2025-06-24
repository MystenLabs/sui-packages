module 0xbdc8096f4cfba2e0ff86edd6c79359e2951c482c8e49e24b07e4832c98a0f3dc::dex_turbos {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        liquidity: u128,
        sqrt_price_current: u128,
        tick_current: u32,
        fee_rate: u32,
        protocol_fee: u32,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
    }

    fun calculate_output_from_input_sqrt_price(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u128 {
        if (arg3) {
            arg2 * arg0 * arg1 / (79228162514264337593543950336 * arg2 / arg1 + arg0) / 79228162514264337593543950336
        } else {
            arg2 * arg0 * arg1 / arg2 / arg1 / 79228162514264337593543950336
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
        assert!(arg0.liquidity > 0, 1);
        let v0 = (arg2 as u128);
        let v1 = v0 - v0 * (arg0.fee_rate as u128) / 1000000;
        let v2 = calculate_output_from_input_sqrt_price(v1, arg0.sqrt_price_current, arg0.liquidity, true);
        let v3 = (v2 as u64);
        assert!(v3 >= arg3, 2);
        assert!(v3 <= 0x2::balance::value<T1>(&arg0.balance_b), 1);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        let v4 = 0x2::balance::split<T1>(&mut arg0.balance_b, v3);
        update_sqrt_price_from_swap<T0, T1>(arg0, v1, v2, true);
        0x2::coin::from_balance<T1>(v4, arg5)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 > 0, 3);
        assert!(arg0.liquidity > 0, 1);
        let v0 = (arg2 as u128);
        let v1 = v0 - v0 * (arg0.fee_rate as u128) / 1000000;
        let v2 = calculate_output_from_input_sqrt_price(v1, arg0.sqrt_price_current, arg0.liquidity, false);
        let v3 = (v2 as u64);
        assert!(v3 >= arg3, 2);
        assert!(v3 <= 0x2::balance::value<T0>(&arg0.balance_a), 1);
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg1));
        let v4 = 0x2::balance::split<T0>(&mut arg0.balance_a, v3);
        update_sqrt_price_from_swap<T0, T1>(arg0, v1, v2, false);
        0x2::coin::from_balance<T0>(v4, arg5)
    }

    fun update_sqrt_price_from_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u128, arg2: u128, arg3: bool) {
        if (arg3) {
            arg0.sqrt_price_current = arg0.sqrt_price_current - arg1 * arg0.sqrt_price_current / (arg0.liquidity + arg1 * arg0.sqrt_price_current / 79228162514264337593543950336);
        } else {
            arg0.sqrt_price_current = arg0.sqrt_price_current + arg1 * 79228162514264337593543950336 / arg0.liquidity;
        };
    }

    // decompiled from Move bytecode v6
}

