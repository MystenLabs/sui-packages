module 0x8f76c8bee3da805a493a3af8abf2c682dc726056141a9eb5f9795a12eb4f0c01::wave_util {
    public fun split_percent<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0 || arg1 < 10000, 1);
        0x2::coin::split<T0>(arg0, 0x2::coin::value<T0>(arg0) * arg1 / 10000, arg2)
    }

    // decompiled from Move bytecode v6
}

