module 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::xf {
    public fun qs<T0, T1>(arg0: &mut 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::M, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: bool) {
        if (!0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::live(arg0)) {
            return
        };
        0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::fd(arg0, 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vf::qo<T0, T1>(arg1, arg2, 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::cy(arg0)));
    }

    public fun sa<T0, T1>(arg0: &mut 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::M, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg2: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vf::sa<T0, T1>(arg1, arg2, arg3, arg4);
        0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::hp<T1>(arg0, &v0);
        v0
    }

    public fun sb<T0, T1>(arg0: &mut 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::M, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::config::GlobalConfig, arg2: &mut 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg3) == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vf::sb<T0, T1>(arg1, arg2, arg3, arg4);
        0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::hp<T0>(arg0, &v0);
        v0
    }

    public fun sp<T0, T1>(arg0: &mut 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::M, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: bool) {
        if (!0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::live(arg0)) {
            return
        };
        0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::sf(arg0, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_sqrt_price<T0, T1>(arg1), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::fee_rate<T0, T1>(arg1), arg2);
    }

    // decompiled from Move bytecode v7
}

