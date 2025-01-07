module 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::market_utils {
    public fun has_enough_balance<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 0);
    }

    public fun split_payable_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: &0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event_registry::Config) : (u64, u64, address) {
        has_enough_balance<T0>(arg0, arg1);
        let (v0, v1) = 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event_registry::get_protocol_info(arg2);
        let v2 = arg1 * v0 / 10000;
        (v2, arg1 - v2, v1)
    }

    // decompiled from Move bytecode v6
}

