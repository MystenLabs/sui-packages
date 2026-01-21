module 0x27ce291ebcdc5b9c461d61f5becce9eb77c1472554a85c02faaa18dda9ec931a::bl {
    public fun sxy<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_sell<T0, T1>(arg0, arg1, arg3, 0x2::coin::into_balance<T0>(arg2), 0x1::option::none<u64>(), arg4);
        0x27ce291ebcdc5b9c461d61f5becce9eb77c1472554a85c02faaa18dda9ec931a::u::tod<T0>(0x2::coin::from_balance<T0>(v0, arg4), 0x2::tx_context::sender(arg4));
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun syx<T0, T1>(arg0: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::swap_buy<T0, T1>(arg0, arg1, arg3, 0x2::coin::into_balance<T1>(arg2), 0x1::option::none<u64>(), arg4);
        0x27ce291ebcdc5b9c461d61f5becce9eb77c1472554a85c02faaa18dda9ec931a::u::tod<T1>(0x2::coin::from_balance<T1>(v1, arg4), 0x2::tx_context::sender(arg4));
        0x2::coin::from_balance<T0>(v0, arg4)
    }

    // decompiled from Move bytecode v6
}

