module 0x29e560001bde1ab4e7eebcad8b95eca52a149a692d87e443713f7f8839623b38::bolt_router {
    public fun swap<T0, T1>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            swap_a_to_b<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        } else {
            swap_b_to_a<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        };
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<T0>(arg0, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg1, arg2, arg3, v0, 0x1::option::none<u64>(), arg5);
        let v4 = v3;
        let v5 = v2;
        if (arg4 == 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::max_amount_in()) {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::utils::transfer_balance<T0>(v5, 0x2::tx_context::sender(arg5), arg5);
        } else {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T0>(arg0, v5);
        };
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T1>(arg0, v4);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<T0, T1>(arg0, b"bolt", 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1), v1, 0x2::balance::value<T1>(&v4), 0x2::balance::value<T0>(&v5));
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::SwapSession, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::take_balance<T1>(arg0, arg4);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg1, arg2, arg3, v0, 0x1::option::none<u64>(), arg5);
        let v4 = v3;
        let v5 = v2;
        if (arg4 == 0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::max_amount_in()) {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::utils::transfer_balance<T1>(v4, 0x2::tx_context::sender(arg5), arg5);
        } else {
            0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T1>(arg0, v4);
        };
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::merge_balance<T0>(arg0, v5);
        0x7e57926855b32baa3b3cabed89380b8d415606fdedadc18e58bd1ef1e60aee48::aggregator::emit_swap_event<T1, T0>(arg0, b"bolt", 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1), v1, 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4));
    }

    // decompiled from Move bytecode v6
}

