module 0x3ee7be8b6bf110d3216162c35484336e76cddaf8b60fdb8818c067c000a28f34::guard {
    public fun assert_min_balance<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 0);
    }

    // decompiled from Move bytecode v7
}

