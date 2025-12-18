module 0x38ae7bb589a5829de16bfb5ddd36a9ad845b80ffeffeaf3241265ba7bec9b297::tradeport_clmm_router {
    public fun swap<T0, T1>(arg0: &mut 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::SwapSession, arg1: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::Pool<T0, T1>, arg2: &0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::versioned::Versioned, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_x_to_y<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            swap_y_to_x<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    fun swap_x_to_y<T0, T1>(arg0: &mut 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::SwapSession, arg1: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::Pool<T0, T1>, arg2: &0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::versioned::Versioned, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::take_balance<T0>(arg0, arg3);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4) = 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::swap<T0, T1>(arg1, true, true, v1, 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::tick_math::min_sqrt_price(), arg2, arg4, arg5);
        let v5 = v3;
        0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::pay<T0, T1>(arg1, v4, v0, 0x2::balance::zero<T1>(), arg2, arg5);
        0x2::balance::destroy_zero<T0>(v2);
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<T1>(arg0, v5);
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::emit_swap_event<T0, T1>(arg0, b"tradeport-clmm", 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::pool_id<T0, T1>(arg1), v1, 0x2::balance::value<T1>(&v5), 0);
    }

    fun swap_y_to_x<T0, T1>(arg0: &mut 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::SwapSession, arg1: &mut 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::Pool<T0, T1>, arg2: &0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::versioned::Versioned, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::take_balance<T1>(arg0, arg3);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4) = 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::swap<T0, T1>(arg1, false, true, v1, 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::tick_math::max_sqrt_price(), arg2, arg4, arg5);
        let v5 = v2;
        0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::pay<T0, T1>(arg1, v4, 0x2::balance::zero<T0>(), v0, arg2, arg5);
        0x2::balance::destroy_zero<T1>(v3);
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::merge_balance<T0>(arg0, v5);
        0x8bcdc1dadd7ccbb67dcea82ee496044d8f54986de20cd7cd1e70c2b40086f1f5::aggregator::emit_swap_event<T1, T0>(arg0, b"tradeport-clmm", 0xfca7146614d9399cd6801519e50db459c9cce8a976398ba7df970d8c76aa0d15::pool::pool_id<T0, T1>(arg1), v1, 0x2::balance::value<T0>(&v5), 0);
    }

    // decompiled from Move bytecode v6
}

