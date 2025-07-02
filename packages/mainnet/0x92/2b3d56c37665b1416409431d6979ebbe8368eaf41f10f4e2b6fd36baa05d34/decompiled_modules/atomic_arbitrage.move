module 0x922b3d56c37665b1416409431d6979ebbe8368eaf41f10f4e2b6fd36baa05d34::atomic_arbitrage {
    public fun calculate_min_profitable_output_with_gas(arg0: u64) : u64 {
        arg0 + arg0 * 1000 / 1000000 + 2200000
    }

    public fun calculate_required_spread_bps(arg0: u64) : u64 {
        1000 + 2200000 * 1000000 / arg0
    }

    public entry fun execute_atomic_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 >= 100000000, 0);
        assert!(arg1 >= calculate_min_profitable_output_with_gas(v0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
    }

    public fun is_profitable_after_gas(arg0: u64, arg1: u64) : bool {
        arg1 >= calculate_min_profitable_output_with_gas(arg0)
    }

    public entry fun validate_and_complete_arbitrage(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= calculate_min_profitable_output_with_gas(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun validate_arbitrage_profit(arg0: u64, arg1: u64) : bool {
        if (arg0 < 100000000) {
            return false
        };
        arg1 >= calculate_min_profitable_output_with_gas(arg0)
    }

    // decompiled from Move bytecode v6
}

