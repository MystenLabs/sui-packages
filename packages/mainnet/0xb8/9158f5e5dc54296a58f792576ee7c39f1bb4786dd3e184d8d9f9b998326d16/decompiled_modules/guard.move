module 0xb89158f5e5dc54296a58f792576ee7c39f1bb4786dd3e184d8d9f9b998326d16::guard {
    public fun assert_min<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 0);
    }

    // decompiled from Move bytecode v7
}

