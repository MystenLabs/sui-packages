module 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::coin_utils {
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

