module 0x5143e9f8797040cda1cecde268824d3dc9a02840f29fb1e00ffa1f215874e483::utils {
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

    public fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x1::option::Option<address>, arg2: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            let v0 = if (0x1::option::is_some<address>(&arg1)) {
                0x1::option::destroy_some<address>(arg1)
            } else {
                0x1::option::destroy_none<address>(arg1);
                0x2::tx_context::sender(arg2)
            };
            0x2::coin::send_funds<T0>(arg0, v0);
        };
    }

    // decompiled from Move bytecode v7
}

