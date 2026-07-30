module 0x5a606deb879b8ed7a1448e9dac4f7d66722204b81f57841e3902e7e2b24f1d44::bolt {
    public fun swap<T0, T1>(arg0: &mut 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::SwapContext, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6);
        };
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::SwapContext, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::take_balance<T0>(arg0, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg1, arg2, arg3, v0, 0x1::option::none<u64>(), arg5);
        let v4 = v3;
        let v5 = v2;
        0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::merge_balance<T1>(arg0, v4);
        if (0x2::balance::value<T0>(&v5) > 0) {
            0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::merge_balance<T0>(arg0, v5);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::emit_swap_event<T0, T1>(arg0, b"BOLT", 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1), v1, 0x2::balance::value<T1>(&v4), 0);
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::SwapContext, arg1: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::take_balance<T1>(arg0, arg4);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg1, arg2, arg3, v0, 0x1::option::none<u64>(), arg5);
        let v4 = v3;
        let v5 = v2;
        0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::merge_balance<T0>(arg0, v5);
        if (0x2::balance::value<T1>(&v4) > 0) {
            0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::merge_balance<T1>(arg0, v4);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
        0x9c71ef43cbe2e0f333fdd8e23d96e8503f53909c24c277d5925c3e0eded9e5b6::router::emit_swap_event<T1, T0>(arg0, b"BOLT", 0x2::object::id<0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>>(arg1), v1, 0x2::balance::value<T0>(&v5), 0);
    }

    // decompiled from Move bytecode v7
}

