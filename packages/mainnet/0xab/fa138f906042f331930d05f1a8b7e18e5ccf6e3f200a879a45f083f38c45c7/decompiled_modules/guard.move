module 0xa41de88b4f32d5d81456dc6b31d12d2bfc0703e0386b903f328b43226d501d15::guard {
    public fun assert_min_value<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 1);
        arg0
    }

    public fun check_min_value<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    // decompiled from Move bytecode v7
}

