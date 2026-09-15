module 0x710ee802f34bc22b66f6ac5ab3de25a818280f2412dd3b71bbfae4106a81dd4c::hibernation {
    public fun begin_winddown<T0, T1>(arg0: &mut 0x710ee802f34bc22b66f6ac5ab3de25a818280f2412dd3b71bbfae4106a81dd4c::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        0x710ee802f34bc22b66f6ac5ab3de25a818280f2412dd3b71bbfae4106a81dd4c::pool::wind_down<T0, T1>(arg0, arg1);
    }

    public fun hibernate<T0, T1>(arg0: &mut 0x710ee802f34bc22b66f6ac5ab3de25a818280f2412dd3b71bbfae4106a81dd4c::pool::Pool<T0, T1>) {
        0x710ee802f34bc22b66f6ac5ab3de25a818280f2412dd3b71bbfae4106a81dd4c::pool::hibernate<T0, T1>(arg0);
    }

    public fun wake<T0, T1>(arg0: &mut 0x710ee802f34bc22b66f6ac5ab3de25a818280f2412dd3b71bbfae4106a81dd4c::pool::Pool<T0, T1>, arg1: &0x710ee802f34bc22b66f6ac5ab3de25a818280f2412dd3b71bbfae4106a81dd4c::config::Config, arg2: &0x710ee802f34bc22b66f6ac5ab3de25a818280f2412dd3b71bbfae4106a81dd4c::pool::PoolCap, arg3: &0x2::clock::Clock) {
        0x710ee802f34bc22b66f6ac5ab3de25a818280f2412dd3b71bbfae4106a81dd4c::pool::wake<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

