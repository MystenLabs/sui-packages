module 0x10fd3d12ebd7bda4835f7bfa0dd888b07151b5eabebc7855514eea8ceb2cde91::route {
    public fun check_coin_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 511);
    }

    // decompiled from Move bytecode v6
}

