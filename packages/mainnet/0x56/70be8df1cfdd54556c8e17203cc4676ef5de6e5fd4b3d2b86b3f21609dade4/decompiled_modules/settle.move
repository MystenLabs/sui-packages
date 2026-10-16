module 0x5670be8df1cfdd54556c8e17203cc4676ef5de6e5fd4b3d2b86b3f21609dade4::settle {
    public fun settle<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
    }

    public fun ensure_min<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    // decompiled from Move bytecode v7
}

