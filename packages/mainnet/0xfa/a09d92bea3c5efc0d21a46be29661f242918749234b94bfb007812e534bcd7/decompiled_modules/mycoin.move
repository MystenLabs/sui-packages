module 0xfaa09d92bea3c5efc0d21a46be29661f242918749234b94bfb007812e534bcd7::mycoin {
    public entry fun final<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
        assert!(0x2::coin::value<T0>(&arg1) > arg0, 101);
    }

    // decompiled from Move bytecode v6
}

