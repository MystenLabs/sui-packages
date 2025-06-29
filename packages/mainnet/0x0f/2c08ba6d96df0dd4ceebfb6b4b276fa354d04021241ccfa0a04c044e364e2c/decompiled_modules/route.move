module 0xf2c08ba6d96df0dd4ceebfb6b4b276fa354d04021241ccfa0a04c044e364e2c::route {
    struct ArbiEvent has copy, drop {
        input_amount: u64,
        output_amount: u64,
    }

    public fun check_coin_threshold<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 511);
    }

    public fun check_profit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg2, 511);
        let v0 = ArbiEvent{
            input_amount  : arg1,
            output_amount : 0x2::coin::value<T0>(arg0),
        };
        0x2::event::emit<ArbiEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

