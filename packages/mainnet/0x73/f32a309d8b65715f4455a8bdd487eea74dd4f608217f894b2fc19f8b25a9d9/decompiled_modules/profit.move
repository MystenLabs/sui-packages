module 0x73f32a309d8b65715f4455a8bdd487eea74dd4f608217f894b2fc19f8b25a9d9::profit {
    public fun assert_at_least<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 0);
        arg0
    }

    public fun assert_in_range<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 >= arg1, 0);
        assert!(v0 <= arg2, 1);
        arg0
    }

    public fun assert_profit_over_input<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1 + arg2, 0);
        arg0
    }

    public fun assert_value_at_least<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 0);
    }

    // decompiled from Move bytecode v7
}

