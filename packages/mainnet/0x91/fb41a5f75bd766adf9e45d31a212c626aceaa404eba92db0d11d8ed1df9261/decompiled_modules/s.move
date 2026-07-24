module 0x5b4dd326d191ad5ff9d7dfd3f135c676e26cb9ed4f96827e4bfaa680f4394163::s {
    public fun dr<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, arg1);
        };
    }

    public fun sf<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: address) {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 0);
        0x2::balance::send_funds<T0>(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

