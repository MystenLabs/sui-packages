module 0x806e8570f5a254d46eccdbc721ae4977aa7b3d8ff53dda1457944d6944a02953::settlement {
    public fun settle<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, arg1);
        };
    }

    public fun settle_below<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: address) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T0>(&arg0) >= arg1) {
            return arg0
        };
        settle<T0>(arg0, arg2);
        0x2::balance::zero<T0>()
    }

    // decompiled from Move bytecode v7
}

