module 0xc4b09d27ec7f9a5c297f64c73d2e8ef822918d18a1930956b30128ac7396a239::guard {
    public fun abort_codes() : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, 1);
        0x1::vector::push_back<u64>(v1, 2);
        0x1::vector::push_back<u64>(v1, 3);
        0x1::vector::push_back<u64>(v1, 4);
        0x1::vector::push_back<u64>(v1, 5);
        0x1::vector::push_back<u64>(v1, 6);
        v0
    }

    public fun assert_coin_at_least<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 5);
    }

    public fun assert_debt_at_least(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 1);
    }

    public fun assert_debt_at_least_u256(arg0: u256, arg1: u256) {
        assert!(arg0 >= arg1, 1);
    }

    public fun assert_liquidatable(arg0: bool) {
        assert!(arg0, 3);
    }

    public fun assert_not_locked(arg0: bool) {
        assert!(!arg0, 4);
    }

    public fun assert_repay_within_cap(arg0: u64, arg1: u64) {
        assert!(arg0 <= arg1, 6);
    }

    public fun assert_undercollateralized(arg0: 0x1::fixed_point32::FixedPoint32, arg1: 0x1::fixed_point32::FixedPoint32) {
        assert!(0x1::fixed_point32::get_raw_value(arg0) < 0x1::fixed_point32::get_raw_value(arg1), 2);
    }

    public fun assert_unhealthy(arg0: bool) {
        assert!(!arg0, 2);
    }

    // decompiled from Move bytecode v7
}

