module 0x85f29767a90cf65a397be62d0b8109e8a27a0d9455a4edd74761d8396b589d5b::slipppage_check {
    public fun assert_slippage<T0, T1>(arg0: &mut 0x39c639460ed2919a902872dd6608481bc2a6b466d048867feaeef95e4a14451d::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg1 < 0x39c639460ed2919a902872dd6608481bc2a6b466d048867feaeef95e4a14451d::pool::sqrt_price<T0, T1>(arg0), 111);
        } else {
            assert!(arg1 > 0x39c639460ed2919a902872dd6608481bc2a6b466d048867feaeef95e4a14451d::pool::sqrt_price<T0, T1>(arg0), 111);
        };
    }

    // decompiled from Move bytecode v6
}

