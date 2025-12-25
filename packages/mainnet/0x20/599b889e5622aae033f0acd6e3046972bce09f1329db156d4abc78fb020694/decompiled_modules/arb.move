module 0x20599b889e5622aae033f0acd6e3046972bce09f1329db156d4abc78fb020694::arb {
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

