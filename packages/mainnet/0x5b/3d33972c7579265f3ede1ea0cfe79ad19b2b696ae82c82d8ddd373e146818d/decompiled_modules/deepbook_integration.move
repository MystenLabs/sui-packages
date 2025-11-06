module 0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::deepbook_integration {
    public fun cancel_order<T0, T1>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::zero<T0>()
    }

    public fun get_best_price<T0, T1>(arg0: bool) : (u64, u64) {
        (1000000, 100000)
    }

    public fun place_limit_order<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::balance::destroy_zero<T0>(arg0);
        12345
    }

    public fun swap_deepbook_a_b<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::balance::destroy_zero<T0>(arg0);
        assert!(0x2::balance::value<T0>(&arg0) * 999 / 1000 >= arg1, 100);
        0x2::balance::zero<T1>()
    }

    public fun swap_deepbook_b_a<T0, T1>(arg0: 0x2::balance::Balance<T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::destroy_zero<T1>(arg0);
        assert!(0x2::balance::value<T1>(&arg0) * 999 / 1000 >= arg1, 100);
        0x2::balance::zero<T0>()
    }

    // decompiled from Move bytecode v6
}

