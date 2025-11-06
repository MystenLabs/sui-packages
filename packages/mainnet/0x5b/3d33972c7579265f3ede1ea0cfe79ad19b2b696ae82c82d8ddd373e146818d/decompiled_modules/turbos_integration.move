module 0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::turbos_integration {
    public fun calculate_turbos_output(arg0: u64, arg1: u64) : u64 {
        arg0 - arg0 * arg1 / 1000000
    }

    public fun get_turbos_sqrt_price<T0, T1, T2>() : u128 {
        1000000000000000000
    }

    public fun swap_turbos_a_b<T0, T1, T2>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::balance::destroy_zero<T0>(arg0);
        assert!(0x2::balance::value<T0>(&arg0) * 997 / 1000 >= arg1, 100);
        0x2::balance::zero<T1>()
    }

    public fun swap_turbos_b_a<T0, T1, T2>(arg0: 0x2::balance::Balance<T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::destroy_zero<T1>(arg0);
        assert!(0x2::balance::value<T1>(&arg0) * 997 / 1000 >= arg1, 100);
        0x2::balance::zero<T0>()
    }

    // decompiled from Move bytecode v6
}

