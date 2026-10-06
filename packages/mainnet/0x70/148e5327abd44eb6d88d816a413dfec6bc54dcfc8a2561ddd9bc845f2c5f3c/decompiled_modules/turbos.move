module 0x70148e5327abd44eb6d88d816a413dfec6bc54dcfc8a2561ddd9bc845f2c5f3c::turbos {
    public fun assert_sqrt_price_ge<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u128) {
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0) >= arg1, 202);
    }

    public fun assert_sqrt_price_le<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u128) {
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0) <= arg1, 201);
    }

    // decompiled from Move bytecode v7
}

