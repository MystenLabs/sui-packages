module 0x444fd9c8acba7fd56c6c0ffea790f9dfdc7e3266b338b061e81fbad0a6a7ee78::clmm {
    public fun swap<T0, T1>(arg0: &mut 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::SwapContext, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::SwapContext, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg3);
        let v1 = 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::take_balance<T0>(arg0, arg4);
        let v2 = 0x2::balance::value<T0>(&v1);
        if (v2 == 0) {
            0x2::balance::destroy_zero<T0>(v1);
            return
        };
        let (v3, v4, v5) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, true, true, v2, 4295048017, arg2, arg5, arg6);
        0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T1>(arg0, v4);
        if (arg4 == 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::max_amount_in()) {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::transfer_balance<T0>(v3, 0x2::tx_context::sender(arg6), arg6);
        } else {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T0>(arg0, v3);
        };
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v5, v1, 0x2::balance::zero<T1>(), arg2, arg6);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::SwapContext, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg3);
        let v1 = 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::take_balance<T1>(arg0, arg4);
        let v2 = 0x2::balance::value<T1>(&v1);
        if (v2 == 0) {
            0x2::balance::destroy_zero<T1>(v1);
            return
        };
        let (v3, v4, v5) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, false, true, v2, 79226673515401279992447579054, arg2, arg5, arg6);
        0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T0>(arg0, v3);
        if (arg4 == 0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::max_amount_in()) {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::transfer_balance<T1>(v4, 0x2::tx_context::sender(arg6), arg6);
        } else {
            0x6fc096341925feff031b3b54c2629f251758c171bea294866473d8253db6dfcd::router::merge_balance<T1>(arg0, v4);
        };
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v5, 0x2::balance::zero<T0>(), v1, arg2, arg6);
    }

    // decompiled from Move bytecode v6
}

