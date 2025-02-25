module 0xddfc20ba1f68cc1f4298d426b3e85f1949fb5924d2b319d51f9b69396203fbb8::slippage_check {
    public fun assert_slippage<T0, T1>(arg0: &mut 0x3813c9e2549befa8e88cb76dc0ce5dad8970adcad477e2eb7c87bc8b9c9433f0::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(arg1 < 0x3813c9e2549befa8e88cb76dc0ce5dad8970adcad477e2eb7c87bc8b9c9433f0::pool::sqrt_price<T0, T1>(arg0), 111);
        } else {
            assert!(arg1 > 0x3813c9e2549befa8e88cb76dc0ce5dad8970adcad477e2eb7c87bc8b9c9433f0::pool::sqrt_price<T0, T1>(arg0), 111);
        };
    }

    // decompiled from Move bytecode v6
}

