module 0x5ac179bc1c4cbb3751a55774123089b17cf6af65104e03fba8f6ef90d8069e56::mbe3b3905396d3e5064565759 {
    public fun f837012f6d2f7cbe40cf4fbbf<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun fb7b35d3d527239367e59cc25<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

