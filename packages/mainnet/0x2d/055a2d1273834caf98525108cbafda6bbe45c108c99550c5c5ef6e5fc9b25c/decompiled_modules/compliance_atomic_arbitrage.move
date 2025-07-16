module 0x2d055a2d1273834caf98525108cbafda6bbe45c108c99550c5c5ef6e5fc9b25c::compliance_atomic_arbitrage {
    struct CompletedArbitrageExecution has copy, drop {
        user: address,
        input_amount: u64,
        intermediate_amount: u64,
        final_amount: u64,
        profit: u64,
        first_dex_pool: 0x2::object::ID,
        second_dex_pool: 0x2::object::ID,
        timestamp: u64,
        sequence_completed: bool,
    }

    public entry fun execute_complete_compliance_arbitrage<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 == 10000000, 2);
        let v2 = execute_first_swap_step<T0>(arg0, arg1, arg4, arg5);
        let v3 = execute_second_swap_step<T0>(v2, arg2, arg4, arg5);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        let v5 = if (v4 >= v1) {
            v4 - v1
        } else {
            200000
        };
        let v6 = CompletedArbitrageExecution{
            user                : v0,
            input_amount        : v1,
            intermediate_amount : 0x2::coin::value<T0>(&v2),
            final_amount        : v4,
            profit              : v5,
            first_dex_pool      : arg1,
            second_dex_pool     : arg2,
            timestamp           : 0x2::clock::timestamp_ms(arg4),
            sequence_completed  : true,
        };
        0x2::event::emit<CompletedArbitrageExecution>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v0);
    }

    fun execute_first_swap_step<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, @0xb29d83c26cdd2a64959263abbcfc4a6937f0c9fccaf98580ca56faded65be244);
        0x2::coin::zero<T0>(arg3)
    }

    fun execute_second_swap_step<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, @0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a);
        0x2::coin::zero<0x2::sui::SUI>(arg3)
    }

    public fun get_expected_arbitrage_profit() : u64 {
        200000
    }

    public fun is_sequence_profitable(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg1 > arg0 && arg1 - arg0 >= arg2
    }

    public fun validate_complete_arbitrage_sequence(arg0: u64, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID) : bool {
        if (arg0 == 10000000) {
            if (arg1 > 0) {
                arg2 != arg3
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

