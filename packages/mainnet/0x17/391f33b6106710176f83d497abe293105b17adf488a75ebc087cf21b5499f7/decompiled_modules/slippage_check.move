module 0x17391f33b6106710176f83d497abe293105b17adf488a75ebc087cf21b5499f7::slippage_check {
    public fun assert_slippage<T0, T1>(arg0: &mut 0xba05f29ce39a2bbcf6279e790fbd811b70b90bd642844586a233a12ecffe8585::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg1 < 0xba05f29ce39a2bbcf6279e790fbd811b70b90bd642844586a233a12ecffe8585::pool::sqrt_price<T0, T1>(arg0), 111);
        } else {
            assert!(arg1 > 0xba05f29ce39a2bbcf6279e790fbd811b70b90bd642844586a233a12ecffe8585::pool::sqrt_price<T0, T1>(arg0), 111);
        };
    }

    // decompiled from Move bytecode v6
}

