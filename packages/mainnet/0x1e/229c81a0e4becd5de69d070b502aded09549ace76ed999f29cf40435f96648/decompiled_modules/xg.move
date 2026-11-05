module 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::xg {
    public fun qs<T0, T1>(arg0: &mut 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::M, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: bool) {
        if (!0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::live(arg0)) {
            return
        };
        0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::fd(arg0, 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vg::qo<T0, T1>(arg1, arg2, arg3, 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::cy(arg0)));
    }

    public fun sa<T0, T1>(arg0: &mut 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::M, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vg::sa<T0, T1>(arg1, arg2, arg3, arg4);
        0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::hp<T1>(arg0, &v0);
        v0
    }

    public fun sb<T0, T1>(arg0: &mut 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::M, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg3) == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
            return 0x2::balance::zero<T0>()
        };
        let v0 = 0x8eda0e922f48259b97940cc4fa468f2dbe0178da0b91d01957aae97acc20b3b3::vg::sb<T0, T1>(arg1, arg2, arg3, arg4);
        0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::hp<T0>(arg0, &v0);
        v0
    }

    public fun sp<T0, T1>(arg0: &mut 0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::M, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: bool) {
        if (!0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::live(arg0)) {
            return
        };
        0x1e229c81a0e4becd5de69d070b502aded09549ace76ed999f29cf40435f96648::m::sf(arg0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg1), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg1), arg2);
    }

    // decompiled from Move bytecode v7
}

