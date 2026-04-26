module 0x3740f74fe8ec268be1fb80de53bcca3e30cb41a004c2677603d1dbd24812d27f::bo {
    public fun a<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::update_pool_version<T0>(arg0);
        let (v0, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x1::option::none<u64>(), arg4);
        0xe7e491e54c1227d5106eef4fa97c6f5697005db4517bca88abcc580963cbaed2::vv::tdb<T0>(v0, arg4);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun b<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::update_pool_version<T0>(arg0);
        let (v0, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T1>(arg3), 0x1::option::none<u64>(), arg4);
        0xe7e491e54c1227d5106eef4fa97c6f5697005db4517bca88abcc580963cbaed2::vv::tdb<T1>(v1, arg4);
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    // decompiled from Move bytecode v7
}

