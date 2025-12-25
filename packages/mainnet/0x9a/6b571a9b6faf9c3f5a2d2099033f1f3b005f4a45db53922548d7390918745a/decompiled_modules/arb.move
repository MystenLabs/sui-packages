module 0x9a6b571a9b6faf9c3f5a2d2099033f1f3b005f4a45db53922548d7390918745a::arb {
    public fun assert_profit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 >= arg1, 2);
        assert!(v0 - arg1 >= arg2, 1);
    }

    public fun check_profit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) : (bool, u64) {
        let v0 = 0x2::coin::value<T0>(arg0);
        if (v0 >= arg1) {
            (true, v0 - arg1)
        } else {
            (false, arg1 - v0)
        }
    }

    // decompiled from Move bytecode v6
}

