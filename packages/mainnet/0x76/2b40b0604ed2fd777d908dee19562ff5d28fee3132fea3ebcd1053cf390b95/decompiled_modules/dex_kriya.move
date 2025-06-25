module 0x762b40b0604ed2fd777d908dee19562ff5d28fee3132fea3ebcd1053cf390b95::dex_kriya {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        lp_supply: u64,
        fee_percentage: u64,
        protocol_fee_percentage: u64,
        cumulative_volume_a: u128,
        cumulative_volume_b: u128,
        last_update_time: u64,
    }

    public fun calculate_price_impact<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        let (v0, v1) = get_reserves<T0, T1>(arg0);
        if (arg2) {
            let v3 = v1 * 10000 / v0;
            let v4 = (v1 - get_amount_out(arg1, v0, v1)) * 10000 / (v0 + arg1);
            if (v3 > v4) {
                (v3 - v4) * 10000 / v3
            } else {
                0
            }
        } else {
            let v5 = v0 * 10000 / v1;
            let v6 = (v0 - get_amount_out(arg1, v1, v0)) * 10000 / (v1 + arg1);
            if (v6 > v5) {
                (v6 - v5) * 10000 / v5
            } else {
                0
            }
        }
    }

    fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128);
        ((v0 * (arg2 as u128) / ((arg1 as u128) + v0)) as u64)
    }

    public fun get_pool_metadata<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u128, u128) {
        (arg0.fee_percentage, arg0.lp_supply, arg0.cumulative_volume_a, arg0.cumulative_volume_b)
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b))
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg2 > 0, 3);
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v1 = 0x2::balance::value<T1>(&arg0.reserve_b);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = arg2 * arg0.fee_percentage / 10000;
        let v3 = get_amount_out(arg2 - v2, v0, v1);
        assert!(v3 >= arg3, 2);
        assert!(v3 < v1, 1);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        arg0.cumulative_volume_a = arg0.cumulative_volume_a + (arg2 as u128);
        arg0.last_update_time = 0x2::clock::timestamp_ms(arg4);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v3), arg5)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 > 0, 3);
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v1 = 0x2::balance::value<T1>(&arg0.reserve_b);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = arg2 * arg0.fee_percentage / 10000;
        let v3 = get_amount_out(arg2 - v2, v1, v0);
        assert!(v3 >= arg3, 2);
        assert!(v3 < v0, 1);
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg1));
        arg0.cumulative_volume_b = arg0.cumulative_volume_b + (arg2 as u128);
        arg0.last_update_time = 0x2::clock::timestamp_ms(arg4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v3), arg5)
    }

    // decompiled from Move bytecode v6
}

