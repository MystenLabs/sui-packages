module 0xdc2c02548fc90f392a7d3c6850627c9f50fd6ea7b2b7781db2abe0acdf88baac::flowx_clmm {
    public fun swap<T0, T1>(arg0: &mut 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::SwapContext, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: u64, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7);
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::SwapContext, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg3);
        let v1 = 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::take_balance<T0>(arg0, arg4);
        let v2 = 0x2::balance::value<T0>(&v1);
        if (v2 == 0) {
            0x2::balance::destroy_zero<T0>(v1);
            return
        };
        let (v3, v4, v5) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, true, true, v2, 4295048017, arg2, arg5, arg6);
        let v6 = v4;
        let v7 = v3;
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::merge_balance<T1>(arg0, v6);
        let v8 = 0x2::balance::value<T0>(&v7);
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::merge_balance<T0>(arg0, v7);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v5, v1, 0x2::balance::zero<T1>(), arg2, arg6);
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::emit_swap_event<T0, T1>(arg0, b"FLOWX_CLMM", 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(v0), v2 - v8, 0x2::balance::value<T1>(&v6), v8);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::SwapContext, arg1: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg3);
        let v1 = 0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::take_balance<T1>(arg0, arg4);
        let v2 = 0x2::balance::value<T1>(&v1);
        if (v2 == 0) {
            0x2::balance::destroy_zero<T1>(v1);
            return
        };
        let (v3, v4, v5) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap<T0, T1>(v0, false, true, v2, 79226673515401279992447579054, arg2, arg5, arg6);
        let v6 = v4;
        let v7 = v3;
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::merge_balance<T0>(arg0, v7);
        let v8 = 0x2::balance::value<T1>(&v6);
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::merge_balance<T1>(arg0, v6);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::pay<T0, T1>(v0, v5, 0x2::balance::zero<T0>(), v1, arg2, arg6);
        0x4c886a17244135f5c4aeee145154c4b0335993d15c4b58871a4996bd54fba4b2::router::emit_swap_event<T1, T0>(arg0, b"FLOWX_CLMM", 0x2::object::id<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>>(v0), v2 - v8, 0x2::balance::value<T0>(&v7), v8);
    }

    // decompiled from Move bytecode v6
}

