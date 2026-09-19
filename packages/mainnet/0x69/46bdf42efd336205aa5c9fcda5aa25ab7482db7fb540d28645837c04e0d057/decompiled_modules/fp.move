module 0x6946bdf42efd336205aa5c9fcda5aa25ab7482db7fb540d28645837c04e0d057::fp {
    public fun epoch(arg0: u64, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == arg0, 122);
    }

    public fun bluefin<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        assert!(within(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2), 102);
    }

    public fun cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        assert!(within(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2), 101);
    }

    fun covers(arg0: &vector<u64>, arg1: u64) : bool {
        let v0 = (arg1 as u128);
        let v1 = 0;
        let v2 = 0;
        while (v1 < v0 && v2 < 0x1::vector::length<u64>(arg0)) {
            v1 = v1 + (*0x1::vector::borrow<u64>(arg0, v2) as u128);
            v2 = v2 + 1;
        };
        v1 >= v0
    }

    public fun deadline(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 120);
    }

    public fun deepbook_ask<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let (_, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, 1, arg1, false, arg3);
        let v2 = v1;
        assert!(covers(&v2, arg2), 110);
    }

    public fun deepbook_bid<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let (_, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, arg1, 9223372036854775807, true, arg3);
        let v2 = v1;
        assert!(covers(&v2, arg2), 111);
    }

    public fun flowx<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg1: u64, arg2: u128, arg3: bool) {
        assert!(within(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T0, T1>(arg0, arg1)), arg2, arg3), 106);
    }

    public fun magma<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        assert!(within(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2), 105);
    }

    public fun momentum<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        assert!(within(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), arg1, arg2), 104);
    }

    public fun turbos<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u128, arg2: bool) {
        assert!(within(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), arg1, arg2), 103);
    }

    fun within(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg0 >= arg1 || arg0 <= arg1
    }

    // decompiled from Move bytecode v7
}

