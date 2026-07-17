module 0xd9cf964cde093c4b9ab5cfc0589f0726d72abbc910446e60706233cb1d1bd4d4::route {
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

    // decompiled from Move bytecode v7
}

