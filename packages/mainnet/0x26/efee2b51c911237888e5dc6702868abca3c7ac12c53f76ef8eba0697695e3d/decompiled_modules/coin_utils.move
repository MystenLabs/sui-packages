module 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::coin_utils {
    public fun put_balance<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>) : u64 {
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg0), arg1)
    }

    public fun return_nonzero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::pay::keep<T0>(arg0, arg1);
        };
    }

    public fun take_balance<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg0), arg1)
    }

    public fun take_full_balance<T0>(arg0: &mut 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::coin::value<T0>(arg0);
        take_balance<T0>(arg0, v0)
    }

    // decompiled from Move bytecode v6
}

