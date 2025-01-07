module 0x825056e31f68069f3b08d6e209c91a0565f1c942529ad8848b68f3b4f2f43680::wave_util {
    public fun split_percent<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 == 0 || arg1 > 10000, 1);
        0x2::coin::split<T0>(arg0, 0x2::coin::value<T0>(arg0) * arg1 / 10000, arg2)
    }

    // decompiled from Move bytecode v6
}

