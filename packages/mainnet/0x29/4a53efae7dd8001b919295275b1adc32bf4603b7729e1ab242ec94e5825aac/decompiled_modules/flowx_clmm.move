module 0xaab972bf281e43b7bdf19594f195e47f2081275e217fce6b66aa6968bccf5c7::flowx_clmm {
    public fun flowx_clmm_flashswap_a2b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt) {
        let (v0, v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg3), true, true, arg4, 4295048017, arg1, arg2, arg5);
        0x2::balance::destroy_zero<T0>(v0);
        (0x2::coin::from_balance<T1>(v1, arg5), v2)
    }

    public fun flowx_clmm_flashswap_b2a<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt) {
        let (v0, v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg3), false, true, arg4, 79226673515401279992447579054, arg1, arg2, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        (0x2::coin::from_balance<T0>(v0, arg5), v2)
    }

    public fun flowx_clmm_repay_flashswap_a2b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt, arg5: &mut 0x2::tx_context::TxContext) {
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg2), arg4, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), arg1, arg5);
    }

    public fun flowx_clmm_repay_flashswap_b2a<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::SwapReceipt, arg5: &mut 0x2::tx_context::TxContext) {
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg2), arg4, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg3), arg1, arg5);
    }

    public fun flowx_clmm_swap_a2b<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg3), true, true, 0x2::coin::value<T0>(&arg4), 4295048017, arg1, arg2, arg5);
        0x2::balance::destroy_zero<T0>(v0);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg3), v2, 0x2::coin::into_balance<T0>(arg4), 0x2::balance::zero<T1>(), arg1, arg5);
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public fun flowx_clmm_swap_b2a<T0, T1>(arg0: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg2: &0x2::clock::Clock, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg3), false, true, 0x2::coin::value<T1>(&arg4), 79226673515401279992447579054, arg1, arg2, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg0, arg3), v2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg4), arg1, arg5);
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    // decompiled from Move bytecode v6
}

