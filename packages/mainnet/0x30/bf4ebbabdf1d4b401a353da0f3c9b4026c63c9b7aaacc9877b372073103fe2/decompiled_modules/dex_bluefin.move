module 0x30bf4ebbabdf1d4b401a353da0f3c9b4026c63c9b7aaacc9877b372073103fe2::dex_bluefin {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        fee_rate: u64,
        k_last: u128,
    }

    public fun get_amount_out<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        let (v0, v1) = get_reserves<T0, T1>(arg0);
        if (arg2) {
            let v3 = (arg1 as u128) * ((10000 - arg0.fee_rate) as u128);
            ((v3 * (v1 as u128) / ((v0 as u128) * (10000 as u128) + v3)) as u64)
        } else {
            let v4 = (arg1 as u128) * ((10000 - arg0.fee_rate) as u128);
            ((v4 * (v0 as u128) / ((v1 as u128) * (10000 as u128) + v4)) as u64)
        }
    }

    public fun get_reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b))
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v1 = 0x2::balance::value<T1>(&arg0.reserve_b);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = (arg2 as u128) * ((10000 - arg0.fee_rate) as u128);
        let v3 = ((v2 * (v1 as u128) / ((v0 as u128) * (10000 as u128) + v2)) as u64);
        assert!(v3 >= arg3, 2);
        assert!(v3 < v1, 1);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        arg0.k_last = (0x2::balance::value<T0>(&arg0.reserve_a) as u128) * (0x2::balance::value<T1>(&arg0.reserve_b) as u128);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v3), arg5)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_a);
        let v1 = 0x2::balance::value<T1>(&arg0.reserve_b);
        assert!(v0 > 0 && v1 > 0, 1);
        let v2 = (arg2 as u128) * ((10000 - arg0.fee_rate) as u128);
        let v3 = ((v2 * (v0 as u128) / ((v1 as u128) * (10000 as u128) + v2)) as u64);
        assert!(v3 >= arg3, 2);
        assert!(v3 < v0, 1);
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg1));
        arg0.k_last = (0x2::balance::value<T0>(&arg0.reserve_a) as u128) * (0x2::balance::value<T1>(&arg0.reserve_b) as u128);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v3), arg5)
    }

    // decompiled from Move bytecode v6
}

