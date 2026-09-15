module 0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::hibernation {
    public fun begin_winddown<T0, T1>(arg0: &mut 0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::pool::wind_down<T0, T1>(arg0, arg1);
    }

    public fun hibernate<T0, T1>(arg0: &mut 0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::pool::Pool<T0, T1>) {
        0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::pool::hibernate<T0, T1>(arg0);
    }

    public fun wake<T0, T1>(arg0: &mut 0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::pool::Pool<T0, T1>, arg1: &0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::config::Config, arg2: &0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::pool::PoolCap, arg3: &0x2::clock::Clock) {
        0x10e6186356a5588e8a06e368809b0d08bfeaa4d067c252082c9d7785c911295d::pool::wake<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

