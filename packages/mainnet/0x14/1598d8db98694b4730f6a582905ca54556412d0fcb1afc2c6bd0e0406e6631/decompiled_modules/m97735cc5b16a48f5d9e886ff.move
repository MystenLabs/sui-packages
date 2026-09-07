module 0x141598d8db98694b4730f6a582905ca54556412d0fcb1afc2c6bd0e0406e6631::m97735cc5b16a48f5d9e886ff {
    public fun f0a153cebc8ba459854a9963d<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun fd173ea597a3be2bd195d4222<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

