module 0x1d23a710a18ed3f1b2f82b2ff968ef62d217558f412e45f2e26a61bc209adb45::atomic_arb {
    public fun assert_and_return<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 1);
        arg0
    }

    public fun assert_profitable<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    // decompiled from Move bytecode v7
}

