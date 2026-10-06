module 0x70148e5327abd44eb6d88d816a413dfec6bc54dcfc8a2561ddd9bc845f2c5f3c::momentum {
    public fun assert_sqrt_price_ge<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128) {
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0) >= arg1, 402);
    }

    public fun assert_sqrt_price_le<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128) {
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0) <= arg1, 401);
    }

    // decompiled from Move bytecode v7
}

