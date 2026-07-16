module 0x3ee7be8b6bf110d3216162c35484336e76cddaf8b60fdb8818c067c000a28f34::guard {
    struct ArbitrageSettled has copy, drop {
        selected_input: u64,
        actual_profit: u64,
        min_profit: u64,
    }

    public fun assert_flash_profit<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64, arg2: u64) {
        let v0 = 0x2::balance::value<T0>(arg0);
        assert!(v0 > 0 && v0 >= arg2, 0);
        let v1 = ArbitrageSettled{
            selected_input : arg1,
            actual_profit  : v0,
            min_profit     : arg2,
        };
        0x2::event::emit<ArbitrageSettled>(v1);
    }

    public fun assert_min_balance<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 0);
    }

    // decompiled from Move bytecode v7
}

