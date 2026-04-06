module 0xb7f92fda2b99fd82bb498e80dbe2bd43f45954d7ae4f31027dbf088d9f54e30a::validation {
    public fun check_deadline(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) < arg1, 1);
    }

    public fun check_min_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 0);
    }

    // decompiled from Move bytecode v6
}

