module 0x9de6a404a57ddf42f53874ae8e50e681220b1eceec66f4a71399abe6325c8737::coin_handler {
    struct CoinEvent has copy, drop, store {
        value: u64,
    }

    public fun check_and_emit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 >= arg1, 4);
        let v1 = CoinEvent{value: v0};
        0x2::event::emit<CoinEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

