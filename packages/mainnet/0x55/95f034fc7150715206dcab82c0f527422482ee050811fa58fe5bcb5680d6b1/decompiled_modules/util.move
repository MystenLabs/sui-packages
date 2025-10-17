module 0x5595f034fc7150715206dcab82c0f527422482ee050811fa58fe5bcb5680d6b1::util {
    public fun split_percent<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0 && arg1 < 10000, 1);
        0x2::coin::split<T0>(arg0, (((0x2::coin::value<T0>(arg0) as u128) * (arg1 as u128) / 10000) as u64), arg2)
    }

    // decompiled from Move bytecode v6
}

