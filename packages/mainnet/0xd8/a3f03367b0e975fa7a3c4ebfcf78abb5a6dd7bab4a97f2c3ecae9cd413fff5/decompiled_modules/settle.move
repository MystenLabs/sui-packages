module 0xd8a3f03367b0e975fa7a3c4ebfcf78abb5a6dd7bab4a97f2c3ecae9cd413fff5::settle {
    public fun destroy_zero<T0>(arg0: 0x2::balance::Balance<T0>) {
        assert!(0x2::balance::value<T0>(&arg0) == 0, 7004);
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public fun settle<T0>(arg0: &0xd8a3f03367b0e975fa7a3c4ebfcf78abb5a6dd7bab4a97f2c3ecae9cd413fff5::control::Control, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: address) {
        0xd8a3f03367b0e975fa7a3c4ebfcf78abb5a6dd7bab4a97f2c3ecae9cd413fff5::control::assert_live(arg0);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 >= arg2, 7003);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
        } else {
            0x2::balance::send_funds<T0>(arg1, arg3);
        };
    }

    public fun assert_min<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 7005);
    }

    // decompiled from Move bytecode v7
}

