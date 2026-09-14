module 0xfa458cad5cf076b46d1e3088bb5661e43b95f081b050281a2312e75dc84fab0f::mac5768d4dca7383ba2ae9bf3 {
    public fun f25b1af7af1bc5f06192e30bb<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun f879ffecc1161c1b95680455e<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

