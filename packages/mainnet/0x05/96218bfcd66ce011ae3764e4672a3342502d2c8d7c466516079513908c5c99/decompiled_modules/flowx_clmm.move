module 0x596218bfcd66ce011ae3764e4672a3342502d2c8d7c466516079513908c5c99::flowx_clmm {
    public fun swap<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u128, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg0, arg3, 0x2::coin::from_balance<T0>(arg2, arg7), 0, arg4, arg5, arg1, arg6, arg7))
    }

    // decompiled from Move bytecode v7
}

