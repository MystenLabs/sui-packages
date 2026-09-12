module 0x3f0ac3779b160caa49894d8406aed5fccd20a7f6dc0758822626c115724aad6c::guard {
    public fun assert_min_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 2695888897);
        arg0
    }

    public fun assert_min_value<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 2695888897);
        arg0
    }

    public fun insufficient_profit_code() : u64 {
        2695888897
    }

    // decompiled from Move bytecode v6
}

