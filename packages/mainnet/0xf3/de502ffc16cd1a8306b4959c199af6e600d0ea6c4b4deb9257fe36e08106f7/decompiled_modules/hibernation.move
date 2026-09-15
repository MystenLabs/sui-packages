module 0xf3de502ffc16cd1a8306b4959c199af6e600d0ea6c4b4deb9257fe36e08106f7::hibernation {
    public fun begin_winddown<T0, T1>(arg0: &mut 0xf3de502ffc16cd1a8306b4959c199af6e600d0ea6c4b4deb9257fe36e08106f7::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        0xf3de502ffc16cd1a8306b4959c199af6e600d0ea6c4b4deb9257fe36e08106f7::pool::wind_down<T0, T1>(arg0, arg1);
    }

    public fun hibernate<T0, T1>(arg0: &mut 0xf3de502ffc16cd1a8306b4959c199af6e600d0ea6c4b4deb9257fe36e08106f7::pool::Pool<T0, T1>) {
        0xf3de502ffc16cd1a8306b4959c199af6e600d0ea6c4b4deb9257fe36e08106f7::pool::hibernate<T0, T1>(arg0);
    }

    public fun wake<T0, T1>(arg0: &mut 0xf3de502ffc16cd1a8306b4959c199af6e600d0ea6c4b4deb9257fe36e08106f7::pool::Pool<T0, T1>, arg1: &0xf3de502ffc16cd1a8306b4959c199af6e600d0ea6c4b4deb9257fe36e08106f7::config::Config, arg2: &0xf3de502ffc16cd1a8306b4959c199af6e600d0ea6c4b4deb9257fe36e08106f7::pool::PoolCap, arg3: &0x2::clock::Clock) {
        0xf3de502ffc16cd1a8306b4959c199af6e600d0ea6c4b4deb9257fe36e08106f7::pool::wake<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

