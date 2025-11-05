module 0xe55920489f74b8bcb84d14579f0be346ea4537e3ecb06508bd39af480abd91ed::flash_arb {
    public entry fun execute_example_arbitrage<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::into_balance<T0>(arg0);
        let v2 = swap_a_b<T0, T1>(v1, arg2);
        let v3 = swap_b_a<T0, T1>(v2, arg2);
        assert!(0x2::balance::value<T0>(&v3) >= 0x2::balance::value<T0>(&v1) + arg1, 401);
        transfer_or_destroy<T0>(v3, v0, arg2);
    }

    public fun merge_to_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) > 0) {
            0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg0), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun swap_a_b<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        assert!(0x2::balance::value<T0>(&arg0) > 0, 402);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::balance::zero<T1>()
    }

    public fun swap_b_a<T0, T1>(arg0: 0x2::balance::Balance<T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T1>(&arg0) > 0, 402);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(arg0, arg1), 0x2::tx_context::sender(arg1));
        0x2::balance::zero<T0>()
    }

    public fun to_balance<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(arg0)
    }

    public fun to_coin<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(arg0, arg1)
    }

    public fun transfer_or_destroy<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

