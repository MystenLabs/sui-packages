module 0x2c4e75d6f73a65f435d1a99636c4483536becd51e0fecd76e2b447104948b30f::hibernation {
    public fun begin_winddown<T0, T1>(arg0: &mut 0x2c4e75d6f73a65f435d1a99636c4483536becd51e0fecd76e2b447104948b30f::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        0x2c4e75d6f73a65f435d1a99636c4483536becd51e0fecd76e2b447104948b30f::pool::wind_down<T0, T1>(arg0, arg1);
    }

    public fun hibernate<T0, T1>(arg0: &mut 0x2c4e75d6f73a65f435d1a99636c4483536becd51e0fecd76e2b447104948b30f::pool::Pool<T0, T1>) {
        0x2c4e75d6f73a65f435d1a99636c4483536becd51e0fecd76e2b447104948b30f::pool::hibernate<T0, T1>(arg0);
    }

    public fun wake<T0, T1>(arg0: &mut 0x2c4e75d6f73a65f435d1a99636c4483536becd51e0fecd76e2b447104948b30f::pool::Pool<T0, T1>, arg1: &0x2c4e75d6f73a65f435d1a99636c4483536becd51e0fecd76e2b447104948b30f::config::Config, arg2: &0x2c4e75d6f73a65f435d1a99636c4483536becd51e0fecd76e2b447104948b30f::pool::PoolCap, arg3: &0x2::clock::Clock) {
        0x2c4e75d6f73a65f435d1a99636c4483536becd51e0fecd76e2b447104948b30f::pool::wake<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

