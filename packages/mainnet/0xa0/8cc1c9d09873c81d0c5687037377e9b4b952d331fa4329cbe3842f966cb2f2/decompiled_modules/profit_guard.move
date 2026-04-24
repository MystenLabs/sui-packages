module 0xa08cc1c9d09873c81d0c5687037377e9b4b952d331fa4329cbe3842f966cb2f2::profit_guard {
    public fun assert_min_profit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) {
        assert!(arg2 > 0, 3);
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 >= arg1, 2);
        assert!(v0 - arg1 >= arg2, 1);
    }

    public fun assert_min_profit_balance<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64, arg2: u64) {
        assert!(arg2 > 0, 3);
        let v0 = 0x2::balance::value<T0>(arg0);
        assert!(v0 >= arg1, 2);
        assert!(v0 - arg1 >= arg2, 1);
    }

    public fun assert_repayable<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 2);
    }

    public fun assert_repayable_balance<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 2);
    }

    public fun measure_profit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) : u64 {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 >= arg1, 2);
        v0 - arg1
    }

    public fun measure_profit_balance<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(arg0);
        assert!(v0 >= arg1, 2);
        v0 - arg1
    }

    // decompiled from Move bytecode v7
}

