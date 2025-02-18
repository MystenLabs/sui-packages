module 0x9ca4929e7ef64feb3b971e9edb5891a782f625962d99ddef5a361875c7e6b247::slippage_check {
    public fun assert_slippage<T0, T1>(arg0: &mut 0x39c639460ed2919a902872dd6608481bc2a6b466d048867feaeef95e4a14451d::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg1 < 0x39c639460ed2919a902872dd6608481bc2a6b466d048867feaeef95e4a14451d::pool::sqrt_price<T0, T1>(arg0), 111);
        } else {
            assert!(arg1 > 0x39c639460ed2919a902872dd6608481bc2a6b466d048867feaeef95e4a14451d::pool::sqrt_price<T0, T1>(arg0), 111);
        };
    }

    // decompiled from Move bytecode v6
}

