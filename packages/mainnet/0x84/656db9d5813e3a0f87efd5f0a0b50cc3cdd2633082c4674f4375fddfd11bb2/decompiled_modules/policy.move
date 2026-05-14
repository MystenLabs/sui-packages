module 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::policy {
    public fun assert_leg_slippage_within(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1, 3);
    }

    public fun assert_min_out(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 4);
    }

    public fun assert_min_shares_out(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 3);
    }

    public fun assert_notional_within_leg_cap(arg0: u64, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        assert!(arg0 <= arg1, 11);
    }

    public fun assert_router_allowed(arg0: &0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::IndexRegistry, arg1: address) {
        assert!(0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::registry::is_router_allowed(arg0, arg1), 7);
    }

    public fun bps_denominator() : u64 {
        10000
    }

    // decompiled from Move bytecode v7
}

