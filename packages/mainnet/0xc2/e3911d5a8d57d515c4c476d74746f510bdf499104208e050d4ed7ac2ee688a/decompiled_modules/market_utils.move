module 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::market_utils {
    public fun has_enough_balance<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 0);
    }

    public fun split_payable_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: &0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event_registry::Config) : (u64, u64, address) {
        has_enough_balance<T0>(arg0, arg1);
        let (v0, v1) = 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::event_registry::get_protocol_info(arg2);
        let v2 = arg1 * v0 / 10000;
        (v2, arg1 - v2, v1)
    }

    // decompiled from Move bytecode v6
}

