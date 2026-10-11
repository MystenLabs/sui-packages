module 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::guards {
    public fun assert_cetus_sqrt<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0) > arg1, 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::errors::guard_cetus());
        } else {
            assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0) < arg1, 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::errors::guard_cetus());
        };
    }

    public fun assert_flowx_sqrt<T0, T1>(arg0: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg0) > arg1, 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::errors::guard_flowx());
        } else {
            assert!(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(arg0) < arg1, 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::errors::guard_flowx());
        };
    }

    public fun assert_momentum_sqrt<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0) > arg1, 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::errors::guard_momentum());
        } else {
            assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0) < arg1, 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::errors::guard_momentum());
        };
    }

    public fun assert_turbos_sqrt<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0) > arg1, 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::errors::guard_turbos());
        } else {
            assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0) < arg1, 0xc53561ba91fcfb7a6914ccbc4ac394986430516117dd2532854fa0e84688c616::errors::guard_turbos());
        };
    }

    public fun check_sqrt(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg0 > arg1 || arg0 < arg1
    }

    // decompiled from Move bytecode v7
}

