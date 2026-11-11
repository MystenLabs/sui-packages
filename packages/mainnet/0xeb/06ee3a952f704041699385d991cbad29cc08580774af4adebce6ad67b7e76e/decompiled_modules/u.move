module 0xeb06ee3a952f704041699385d991cbad29cc08580774af4adebce6ad67b7e76e::u {
    public fun cot<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    public fun tod<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::balance::send_funds<T0>(0x2::coin::into_balance<T0>(arg0), arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

