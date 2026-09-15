module 0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::hibernation {
    public fun begin_winddown<T0, T1>(arg0: &mut 0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::pool::wind_down<T0, T1>(arg0, arg1);
    }

    public fun hibernate<T0, T1>(arg0: &mut 0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::pool::Pool<T0, T1>) {
        0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::pool::hibernate<T0, T1>(arg0);
    }

    public fun wake<T0, T1>(arg0: &mut 0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::pool::Pool<T0, T1>, arg1: &0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::config::Config, arg2: &0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::pool::PoolCap, arg3: &0x2::clock::Clock) {
        0xe1d681485cc349c8d69d625f3b040bcd3b103461c8ae32542a10a53001028d15::pool::wake<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

