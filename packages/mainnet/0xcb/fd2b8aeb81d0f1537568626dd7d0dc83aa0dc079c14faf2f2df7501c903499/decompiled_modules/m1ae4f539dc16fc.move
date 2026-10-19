module 0x9ade52d362349ac2132bd59b16a7e18efaba6c5c8902eb0e35c3a5df817bd6f5::m1ae4f539dc16fc {
    public fun f0efc7372ce59<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: u128, arg3: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg5) == 0) {
            0x2::balance::destroy_zero<T0>(arg5);
            return (0x2::balance::zero<T1>(), 0x2::balance::zero<T0>())
        };
        (0x2::coin::into_balance<T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg0, arg1, 0x2::coin::from_balance<T0>(arg5, arg6), 0, arg2, 18446744073709551615, arg3, arg4, arg6)), 0x2::balance::zero<T0>())
    }

    // decompiled from Move bytecode v7
}

