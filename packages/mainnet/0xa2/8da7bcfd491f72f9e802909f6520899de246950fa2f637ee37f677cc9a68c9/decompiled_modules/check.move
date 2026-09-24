module 0xa28da7bcfd491f72f9e802909f6520899de246950fa2f637ee37f677cc9a68c9::check {
    fun check(arg0: u128, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg0 <= arg1, 101);
        } else {
            assert!(arg0 >= arg1, 101);
        };
    }

    public fun cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        check(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun momentum<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        check(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), arg1, arg2);
    }

    public fun take_profit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 102);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
    }

    public fun turbos<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u128, arg2: bool) {
        check(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0), arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

