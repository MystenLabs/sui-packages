module 0x806fe45261a18dd3e9614f397514ca40d5cbe72a58443c86aae2442e5e4caddb::s {
    public fun dr<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, arg1);
        };
    }

    public fun sa<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 1);
        arg0
    }

    public fun sf<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: address) {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 0);
        0x2::balance::send_funds<T0>(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

