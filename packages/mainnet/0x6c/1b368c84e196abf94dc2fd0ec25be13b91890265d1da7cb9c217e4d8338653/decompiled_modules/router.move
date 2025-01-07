module 0x6c1b368c84e196abf94dc2fd0ec25be13b91890265d1da7cb9c217e4d8338653::router {
    public fun check_amount<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 0);
        arg0
    }

    // decompiled from Move bytecode v6
}

