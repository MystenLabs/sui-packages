module 0xbccbca34f4e275c58c606efb89d18ef7dcfec431054fced3abc85d207a8bdbb0::slippage_check {
    public fun assert_slippage<T0, T1>(arg0: &mut 0x3edaaa9fdcc23de76ebb51fa5bbba2922df3abbea4ac1c4f957e9c910da7b859::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg1 < 0x3edaaa9fdcc23de76ebb51fa5bbba2922df3abbea4ac1c4f957e9c910da7b859::pool::sqrt_price<T0, T1>(arg0), 111);
        } else {
            assert!(arg1 > 0x3edaaa9fdcc23de76ebb51fa5bbba2922df3abbea4ac1c4f957e9c910da7b859::pool::sqrt_price<T0, T1>(arg0), 111);
        };
    }

    // decompiled from Move bytecode v6
}

