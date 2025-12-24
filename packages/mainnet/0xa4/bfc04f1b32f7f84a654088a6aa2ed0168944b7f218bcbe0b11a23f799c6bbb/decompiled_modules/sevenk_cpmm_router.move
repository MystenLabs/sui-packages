module 0xa4bfc04f1b32f7f84a654088a6aa2ed0168944b7f218bcbe0b11a23f799c6bbb::sevenk_cpmm_router {
    public fun swap<T0, T1, T2>(arg0: &mut 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::SwapSession, arg1: &mut 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>, arg2: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleHolder, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a_to_b<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        } else {
            swap_b_to_a<T0, T1, T2>(arg0, arg1, arg2, arg4, arg5);
        };
    }

    fun swap_a_to_b<T0, T1, T2>(arg0: &mut 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::SwapSession, arg1: &mut 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>, arg2: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleHolder, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::swap_x_to_y<T0, T1, T2>(arg1, arg2, 0x2::coin::from_balance<T0>(v0, arg4), 0, arg4);
        0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v2));
        0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::emit_swap_event<T0, T1>(arg0, b"sevenk-cpmm", 0x2::object::id<0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>>(arg1), v1, 0x2::coin::value<T1>(&v2), 0);
    }

    fun swap_b_to_a<T0, T1, T2>(arg0: &mut 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::SwapSession, arg1: &mut 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>, arg2: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleHolder, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::swap_y_to_x<T0, T1, T2>(arg1, arg2, 0x2::coin::from_balance<T1>(v0, arg4), 0, arg4);
        0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v2));
        0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::emit_swap_event<T1, T0>(arg0, b"sevenk-cpmm", 0x2::object::id<0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1::Pool<T0, T1, T2>>(arg1), v1, 0x2::coin::value<T0>(&v2), 0);
    }

    // decompiled from Move bytecode v6
}

