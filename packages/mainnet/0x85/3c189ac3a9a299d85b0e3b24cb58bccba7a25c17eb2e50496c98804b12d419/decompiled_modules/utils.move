module 0x853c189ac3a9a299d85b0e3b24cb58bccba7a25c17eb2e50496c98804b12d419::utils {
    public fun check_coin_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 >= arg1, v0);
    }

    public fun coin0_to_two_balance<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0x2::coin::into_balance<T0>(arg0), 0x2::coin::into_balance<T1>(0x2::coin::zero<T1>(arg1)))
    }

    public fun coin1_to_two_balance<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (0x2::coin::into_balance<T0>(0x2::coin::zero<T0>(arg1)), 0x2::coin::into_balance<T1>(arg0))
    }

    public fun split_coin0_to_two_balance<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, arg1, arg2)), 0x2::coin::into_balance<T1>(0x2::coin::zero<T1>(arg2)))
    }

    public fun split_coin1_to_two_balance<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        (arg0, 0x2::coin::into_balance<T0>(0x2::coin::zero<T0>(arg2)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg0, arg1, arg2)))
    }

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun two_balance_to_leave_coin0<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(arg1, arg2), arg2);
        0x2::coin::from_balance<T0>(arg0, arg2)
    }

    public fun two_balance_to_leave_coin1<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(arg0, arg2), arg2);
        0x2::coin::from_balance<T1>(arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

