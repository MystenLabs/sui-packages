module 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::hibernation {
    public fun begin_winddown<T0, T1>(arg0: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::pool::wind_down<T0, T1>(arg0, arg1);
    }

    public fun hibernate<T0, T1>(arg0: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::pool::Pool<T0, T1>) {
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::pool::hibernate<T0, T1>(arg0);
    }

    public fun wake<T0, T1>(arg0: &mut 0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::pool::Pool<T0, T1>, arg1: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::config::Config, arg2: &0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::pool::PoolCap, arg3: &0x2::clock::Clock) {
        0xf44e1655cdedd2ac83485c3184b955df52a9a7c1a332472662fa056aeb20de27::pool::wake<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

