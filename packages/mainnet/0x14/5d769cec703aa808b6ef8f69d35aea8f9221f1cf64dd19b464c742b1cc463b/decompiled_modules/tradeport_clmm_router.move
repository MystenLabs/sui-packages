module 0x145d769cec703aa808b6ef8f69d35aea8f9221f1cf64dd19b464c742b1cc463b::tradeport_clmm_router {
    public fun swap<T0, T1>(arg0: &mut 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::SwapSession, arg1: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool_manager::PoolRegistry, arg2: u64, arg3: &0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::versioned::Versioned, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_x_to_y<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        } else {
            swap_y_to_x<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
        };
    }

    fun swap_x_to_y<T0, T1>(arg0: &mut 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::SwapSession, arg1: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool_manager::PoolRegistry, arg2: u64, arg3: &0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::versioned::Versioned, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::take_balance<T0>(arg0, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2);
        let v3 = 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::swap_router::swap_exact_x_to_y<T0, T1>(v2, 0x2::coin::from_balance<T0>(v0, arg6), 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::tick_math::min_sqrt_price() + 1, arg3, arg5, arg6);
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<T1>(arg0, v3);
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::emit_swap_event<T0, T1>(arg0, b"tradeport-clmm", 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::pool_id<T0, T1>(v2), v1, 0x2::balance::value<T1>(&v3), 0);
    }

    fun swap_y_to_x<T0, T1>(arg0: &mut 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::SwapSession, arg1: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool_manager::PoolRegistry, arg2: u64, arg3: &0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::versioned::Versioned, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::take_balance<T1>(arg0, arg4);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool_manager::borrow_mut_pool<T0, T1>(arg1, arg2);
        let v3 = 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::swap_router::swap_exact_y_to_x<T0, T1>(v2, 0x2::coin::from_balance<T1>(v0, arg6), 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::tick_math::max_sqrt_price() - 1, arg3, arg5, arg6);
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<T0>(arg0, v3);
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::emit_swap_event<T1, T0>(arg0, b"tradeport-clmm", 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::pool_id<T0, T1>(v2), v1, 0x2::balance::value<T0>(&v3), 0);
    }

    // decompiled from Move bytecode v6
}

