module 0x4a6b689ebb5f7dc7b1ad5318a9745ffb182da85b2f0b1eb303dc61a2ad7b6214::flowx_clmm {
    public fun swap_exact_in_a_to_b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::coin::into_balance<T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T0, T1>(arg0, arg1, 0x2::coin::from_balance<T0>(arg2, arg6), 1, arg3, 18446744073709551615, arg4, arg5, arg6))
    }

    public fun swap_exact_in_b_to_a<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: 0x2::balance::Balance<T1>, arg3: u128, arg4: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::coin::into_balance<T0>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::swap_router::swap_exact_input<T1, T0>(arg0, arg1, 0x2::coin::from_balance<T1>(arg2, arg6), 1, arg3, 18446744073709551615, arg4, arg5, arg6))
    }

    // decompiled from Move bytecode v7
}

