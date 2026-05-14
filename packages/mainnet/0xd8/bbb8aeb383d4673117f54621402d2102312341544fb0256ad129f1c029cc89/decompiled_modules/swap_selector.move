module 0xd8bbb8aeb383d4673117f54621402d2102312341544fb0256ad129f1c029cc89::swap_selector {
    public fun assert_liq_stage(arg0: bool) {
        assert!(arg0, 14680273);
    }

    public fun assert_min_u64(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 14680276);
    }

    public fun assert_repay_stage(arg0: bool) {
        assert!(arg0, 14680275);
    }

    public fun assert_seize_min<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 14680276);
    }

    public fun assert_swap_stage(arg0: bool) {
        assert!(arg0, 14680274);
    }

    public fun e_liq_fail() : u64 {
        14680273
    }

    public fun e_repay_fail() : u64 {
        14680275
    }

    public fun e_seize_below_min() : u64 {
        14680276
    }

    public fun e_swap_fail() : u64 {
        14680274
    }

    // decompiled from Move bytecode v6
}

