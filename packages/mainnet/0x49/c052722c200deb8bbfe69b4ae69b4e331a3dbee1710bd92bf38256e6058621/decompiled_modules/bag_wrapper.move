module 0x49c052722c200deb8bbfe69b4ae69b4e331a3dbee1710bd92bf38256e6058621::bag_wrapper {
    public fun create_and_destroy<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg0) {
            0x2::coin::destroy_zero<T0>(0x2::coin::zero<T0>(arg1));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

