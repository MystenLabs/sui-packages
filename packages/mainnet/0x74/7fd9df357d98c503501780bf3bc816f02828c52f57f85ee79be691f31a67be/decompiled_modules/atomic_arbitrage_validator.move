module 0x747fd9df357d98c503501780bf3bc816f02828c52f57f85ee79be691f31a67be::atomic_arbitrage_validator {
    struct ArbitrageInitiated has copy, drop {
        user: address,
        input_amount: u64,
        timestamp: u64,
    }

    struct ArbitrageCompleted has copy, drop {
        user: address,
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
        timestamp: u64,
    }

    public fun get_dex_addresses() : (address, address) {
        (@0xd02012c71c1a6a221e540c36c37c81e0224907fe1ee05bfe250025654ff17103, @0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244)
    }

    public fun get_required_input() : u64 {
        10000000
    }

    public fun is_profitable(arg0: u64, arg1: u64) : bool {
        arg0 >= arg1
    }

    public fun validate_arbitrage_completion(arg0: &0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg0);
        let v1 = if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        };
        assert!(v1 > 0, 2);
        let v2 = ArbitrageCompleted{
            user           : 0x2::tx_context::sender(arg2),
            initial_amount : arg1,
            final_amount   : v0,
            profit         : v1,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<ArbitrageCompleted>(v2);
    }

    public fun validate_arbitrage_input(arg0: &0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg0);
        assert!(v0 == 10000000, 1);
        let v1 = ArbitrageInitiated{
            user         : 0x2::tx_context::sender(arg1),
            input_amount : v0,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::event::emit<ArbitrageInitiated>(v1);
    }

    // decompiled from Move bytecode v6
}

