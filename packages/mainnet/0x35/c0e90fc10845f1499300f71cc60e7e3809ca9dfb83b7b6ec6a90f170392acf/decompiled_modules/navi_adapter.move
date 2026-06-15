module 0x35c0e90fc10845f1499300f71cc60e7e3809ca9dfb83b7b6ec6a90f170392acf::navi_adapter {
    public fun mock_supply(arg0: &mut u64, arg1: u64) {
        *arg0 = *arg0 + arg1;
    }

    public fun mock_withdraw(arg0: &mut u64, arg1: u64) {
        assert!(*arg0 >= arg1, 0);
        *arg0 = *arg0 - arg1;
    }

    public fun supplied_amount(arg0: u64) : u64 {
        arg0
    }

    // decompiled from Move bytecode v7
}

