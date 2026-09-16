module 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::hibernation {
    public fun begin_winddown<T0, T1>(arg0: &mut 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::wind_down<T0, T1>(arg0, arg1);
    }

    public fun hibernate<T0, T1>(arg0: &mut 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::Pool<T0, T1>) {
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::hibernate<T0, T1>(arg0);
    }

    public fun wake<T0, T1>(arg0: &mut 0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::Pool<T0, T1>, arg1: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::config::Config, arg2: &0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::PoolCap, arg3: &0x2::clock::Clock) {
        0xaedb8c9a905a778e831aeb4928f660210a7a645925348a7c4ec1cb4a6a3fd16e::pool::wake<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

