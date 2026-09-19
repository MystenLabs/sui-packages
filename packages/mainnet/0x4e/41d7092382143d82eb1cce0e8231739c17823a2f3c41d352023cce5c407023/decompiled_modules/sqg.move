module 0x4e41d7092382143d82eb1cce0e8231739c17823a2f3c41d352023cce5c407023::sqg {
    public fun acq<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u256, arg2: bool) {
        aq64aq96(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun al<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128) {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0) >= arg1, 101);
    }

    public fun am<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128) {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0) <= arg1, 101);
    }

    public fun aq64aq96(arg0: u128, arg1: u256, arg2: bool) {
        if (arg2) {
            assert!((arg0 as u256) << 32 >= arg1, 101);
        } else {
            assert!((arg0 as u256) << 32 <= arg1, 101);
        };
    }

    public fun ca1(arg0: u128, arg1: u256, arg2: bool) {
        aq64aq96(arg0, arg1, arg2);
    }

    public fun csx64(arg0: u128, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg0 >= arg1, 101);
        } else {
            assert!(arg0 <= arg1, 101);
        };
    }

    // decompiled from Move bytecode v7
}

