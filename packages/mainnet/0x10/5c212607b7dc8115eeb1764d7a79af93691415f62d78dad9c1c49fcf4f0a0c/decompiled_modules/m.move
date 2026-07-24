module 0x105c212607b7dc8115eeb1764d7a79af93691415f62d78dad9c1c49fcf4f0a0c::m {
    public fun fx<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: u128, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg0, arg3, 0x2::coin::from_balance<T0>(arg2, arg8), arg4, arg5, arg6, arg1, arg7, arg8))
    }

    // decompiled from Move bytecode v7
}

