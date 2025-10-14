module 0x79fa20e2a4cebf9ca7cdc044dc3fb284b092183c5834a835ce416969f8df3a87::validation {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) < arg1, 1);
    }

    public fun check_min_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 0);
    }

    // decompiled from Move bytecode v6
}

