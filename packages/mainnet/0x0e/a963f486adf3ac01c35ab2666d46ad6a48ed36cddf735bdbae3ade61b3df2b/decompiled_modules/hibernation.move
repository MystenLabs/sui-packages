module 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::hibernation {
    public fun begin_winddown<T0, T1>(arg0: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::wind_down<T0, T1>(arg0, arg1);
    }

    public fun hibernate<T0, T1>(arg0: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::Pool<T0, T1>) {
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::hibernate<T0, T1>(arg0);
    }

    public fun wake<T0, T1>(arg0: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::Pool<T0, T1>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::PoolCap, arg3: &0x2::clock::Clock) {
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::wake<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

