module 0xf5431d876ab48e9a3ee991a0cac1b63460c52976d8ee674f463610ef8d7b9e71::swap {
    struct Treasury<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
    }

    public fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0, T1>{
            id     : 0x2::object::new(arg0),
            coin_a : 0x2::balance::zero<T0>(),
            coin_b : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<Treasury<T0, T1>>(v0);
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Treasury<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>) {
        let (v0, v1) = get_coin_mut<T0, T1>(arg0);
        0x2::balance::join<T0>(v0, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(v1, 0x2::coin::into_balance<T1>(arg2));
    }

    public(friend) fun get_coin<T0, T1>(arg0: &Treasury<T0, T1>) : (&0x2::balance::Balance<T0>, &0x2::balance::Balance<T1>) {
        (&arg0.coin_a, &arg0.coin_b)
    }

    public(friend) fun get_coin_mut<T0, T1>(arg0: &mut Treasury<T0, T1>) : (&mut 0x2::balance::Balance<T0>, &mut 0x2::balance::Balance<T1>) {
        (&mut arg0.coin_a, &mut arg0.coin_b)
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut Treasury<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = get_coin_mut<T0, T1>(arg0);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(0x2::balance::value<T1>(v1) >= v2, 0);
        0x2::balance::join<T0>(v0, 0x2::coin::into_balance<T0>(arg1));
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v1, v2), arg2)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Treasury<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = get_coin_mut<T0, T1>(arg0);
        let v2 = 0x2::coin::value<T1>(&arg1);
        assert!(0x2::balance::value<T0>(v0) >= v2, 0);
        0x2::balance::join<T1>(v1, 0x2::coin::into_balance<T1>(arg1));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, v2), arg2)
    }

    // decompiled from Move bytecode v6
}

