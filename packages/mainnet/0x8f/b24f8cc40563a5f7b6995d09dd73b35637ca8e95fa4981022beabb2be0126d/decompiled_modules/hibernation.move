module 0x8fb24f8cc40563a5f7b6995d09dd73b35637ca8e95fa4981022beabb2be0126d::hibernation {
    public fun begin_winddown<T0, T1>(arg0: &mut 0x8fb24f8cc40563a5f7b6995d09dd73b35637ca8e95fa4981022beabb2be0126d::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        0x8fb24f8cc40563a5f7b6995d09dd73b35637ca8e95fa4981022beabb2be0126d::pool::wind_down<T0, T1>(arg0, arg1);
    }

    public fun hibernate<T0, T1>(arg0: &mut 0x8fb24f8cc40563a5f7b6995d09dd73b35637ca8e95fa4981022beabb2be0126d::pool::Pool<T0, T1>) {
        0x8fb24f8cc40563a5f7b6995d09dd73b35637ca8e95fa4981022beabb2be0126d::pool::hibernate<T0, T1>(arg0);
    }

    public fun wake<T0, T1>(arg0: &mut 0x8fb24f8cc40563a5f7b6995d09dd73b35637ca8e95fa4981022beabb2be0126d::pool::Pool<T0, T1>, arg1: &0x8fb24f8cc40563a5f7b6995d09dd73b35637ca8e95fa4981022beabb2be0126d::config::Config, arg2: &0x8fb24f8cc40563a5f7b6995d09dd73b35637ca8e95fa4981022beabb2be0126d::pool::PoolCap, arg3: &0x2::clock::Clock) {
        0x8fb24f8cc40563a5f7b6995d09dd73b35637ca8e95fa4981022beabb2be0126d::pool::wake<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

