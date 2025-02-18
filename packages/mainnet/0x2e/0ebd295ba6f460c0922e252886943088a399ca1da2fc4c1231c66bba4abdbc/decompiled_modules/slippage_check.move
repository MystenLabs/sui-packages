module 0x2e0ebd295ba6f460c0922e252886943088a399ca1da2fc4c1231c66bba4abdbc::slippage_check {
    public fun assert_slippage<T0, T1>(arg0: &mut 0x39c639460ed2919a902872dd6608481bc2a6b466d048867feaeef95e4a14451d::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg1 < 0x39c639460ed2919a902872dd6608481bc2a6b466d048867feaeef95e4a14451d::pool::sqrt_price<T0, T1>(arg0), 111);
        } else {
            assert!(arg1 > 0x39c639460ed2919a902872dd6608481bc2a6b466d048867feaeef95e4a14451d::pool::sqrt_price<T0, T1>(arg0), 111);
        };
    }

    // decompiled from Move bytecode v6
}

