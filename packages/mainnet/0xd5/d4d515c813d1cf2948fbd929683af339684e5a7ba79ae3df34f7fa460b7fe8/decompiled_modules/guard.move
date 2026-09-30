module 0xd5d4d515c813d1cf2948fbd929683af339684e5a7ba79ae3df34f7fa460b7fe8::guard {
    public fun assert_min_return<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1 + arg2 + arg3, 0);
    }

    // decompiled from Move bytecode v7
}

