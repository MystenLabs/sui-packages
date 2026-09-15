module 0xddd8e7b63472e8b5aefa7ca3c9411ce89406a9853f2e513db96d4b3ee603d676::hibernation {
    public fun begin_winddown<T0, T1>(arg0: &mut 0xddd8e7b63472e8b5aefa7ca3c9411ce89406a9853f2e513db96d4b3ee603d676::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        0xddd8e7b63472e8b5aefa7ca3c9411ce89406a9853f2e513db96d4b3ee603d676::pool::wind_down<T0, T1>(arg0, arg1);
    }

    public fun hibernate<T0, T1>(arg0: &mut 0xddd8e7b63472e8b5aefa7ca3c9411ce89406a9853f2e513db96d4b3ee603d676::pool::Pool<T0, T1>) {
        0xddd8e7b63472e8b5aefa7ca3c9411ce89406a9853f2e513db96d4b3ee603d676::pool::hibernate<T0, T1>(arg0);
    }

    public fun wake<T0, T1>(arg0: &mut 0xddd8e7b63472e8b5aefa7ca3c9411ce89406a9853f2e513db96d4b3ee603d676::pool::Pool<T0, T1>, arg1: &0xddd8e7b63472e8b5aefa7ca3c9411ce89406a9853f2e513db96d4b3ee603d676::config::Config, arg2: &0xddd8e7b63472e8b5aefa7ca3c9411ce89406a9853f2e513db96d4b3ee603d676::pool::PoolCap, arg3: &0x2::clock::Clock) {
        0xddd8e7b63472e8b5aefa7ca3c9411ce89406a9853f2e513db96d4b3ee603d676::pool::wake<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

