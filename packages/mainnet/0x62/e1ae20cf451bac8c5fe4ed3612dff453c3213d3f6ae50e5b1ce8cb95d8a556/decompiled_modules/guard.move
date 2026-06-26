module 0x62e1ae20cf451bac8c5fe4ed3612dff453c3213d3f6ae50e5b1ce8cb95d8a556::guard {
    public fun assert_min_value<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    // decompiled from Move bytecode v7
}

