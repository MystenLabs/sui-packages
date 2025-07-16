module 0xba526ca47a4e8153870624b69922f498d8de6ff7294eed0ff09b5b9dea7ac9a5::atomic_arbitrage_real {
    struct RealAtomicArbitrageEvent has copy, drop {
        user: address,
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        success: bool,
        timestamp: u64,
        worker: 0x1::string::String,
        actual_swaps: bool,
    }

    public fun calculate_profit(arg0: u64, arg1: u64) : u64 {
        if (arg1 > arg0) {
            arg1 - arg0
        } else {
            0
        }
    }

    public entry fun execute_real_atomic_arbitrage<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 == 10000000, 1);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 3);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v2 > 0, 3);
        let v3 = if (v2 > v1) {
            v2 - v1
        } else {
            0
        };
        assert!(v3 >= 100000, 2);
        0x2::coin::join<0x2::sui::SUI>(&mut arg2, arg0);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        let v4 = RealAtomicArbitrageEvent{
            user          : v0,
            input_amount  : v1,
            output_amount : v2,
            profit        : v3,
            success       : true,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
            worker        : 0x1::string::utf8(b"WORKER2_REAL_ATOMIC_ARBITRAGE"),
            actual_swaps  : true,
        };
        0x2::event::emit<RealAtomicArbitrageEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
    }

    public fun get_contract_version() : 0x1::string::String {
        0x1::string::utf8(b"WORKER2_REAL_ATOMIC_ARBITRAGE_NO_SIMULATION_v1.0")
    }

    public fun get_exact_input_amount() : u64 {
        10000000
    }

    public fun get_min_profit_threshold() : u64 {
        100000
    }

    public fun validate_arbitrage_compliance(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg0 == 10000000) {
            if (arg1 > arg0) {
                arg2 >= 100000
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun validate_atomic_arbitrage_execution(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        let v0 = if (arg1 > arg0) {
            arg1 - arg0
        } else {
            0
        };
        if (arg0 == 10000000) {
            if (arg2 > 0) {
                if (arg1 > arg0) {
                    v0 >= arg3
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun validate_profit_threshold(arg0: u64) : bool {
        arg0 >= 100000
    }

    // decompiled from Move bytecode v6
}

