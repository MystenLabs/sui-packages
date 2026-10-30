module 0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::guard {
    public fun repay_amount(arg0: u64, arg1: u64) : u64 {
        require_positive_repay(arg1);
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun require_cover(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 >= arg1 && arg0 - arg1 >= arg2, 103);
    }

    public fun require_deadline(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(arg1 == 0 || 0x2::clock::timestamp_ms(arg0) <= arg1, 104);
    }

    public fun require_debt(arg0: u64, arg1: u64) {
        assert!(arg0 > 0, 101);
        assert!(arg0 >= arg1, 102);
    }

    public fun require_liquidatable(arg0: bool) {
        assert!(arg0, 100);
    }

    public fun require_min_out(arg0: u64, arg1: u64) {
        assert!(arg1 > 0, 106);
        assert!(arg0 >= arg1, 105);
    }

    public fun require_min_profit<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 103);
    }

    public fun require_positive_min_out(arg0: u64) {
        assert!(arg0 > 0, 106);
    }

    public fun require_positive_repay(arg0: u64) {
        assert!(arg0 > 0, 110);
    }

    public fun require_price_fresh(arg0: u64, arg1: u64, arg2: u64) {
        require_price_not_future(arg0, arg1);
        assert!(arg1 - arg0 <= arg2, 107);
    }

    public fun require_price_not_future(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1, 108);
    }

    // decompiled from Move bytecode v7
}

