module 0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::hibernation {
    public fun begin_winddown<T0, T1>(arg0: &mut 0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::pool::wind_down<T0, T1>(arg0, arg1);
    }

    public fun hibernate<T0, T1>(arg0: &mut 0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::pool::Pool<T0, T1>) {
        0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::pool::hibernate<T0, T1>(arg0);
    }

    public fun wake<T0, T1>(arg0: &mut 0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::pool::Pool<T0, T1>, arg1: &0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::config::Config, arg2: &0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::pool::PoolCap, arg3: &0x2::clock::Clock) {
        0x8455291dcd7dc27c3619301bb839cae0d4d855eb46463a32cf81b66985a19868::pool::wake<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

