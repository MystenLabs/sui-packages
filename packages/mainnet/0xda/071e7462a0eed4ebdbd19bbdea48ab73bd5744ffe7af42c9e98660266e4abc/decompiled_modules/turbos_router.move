module 0xa8f7b7893fd8edb8510b98e0cf19e9ea27b714c861113c79ca062ef96b2b378d::turbos_router {
    public fun a1t<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0) >= arg1, 7);
        } else {
            assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0) <= arg1, 7);
        };
    }

    // decompiled from Move bytecode v7
}

