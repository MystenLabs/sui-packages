module 0xa6900a4426d75a63c737e13d9dadb76ace311764f44d8da93a58e30cc79c0cd3::route {
    public fun check_coin_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 511);
    }

    // decompiled from Move bytecode v6
}

