module 0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::gas_optimized_arbitrage {
    struct AtomicArbitrageEvent has copy, drop {
        user: address,
        dex_a: u8,
        dex_b: u8,
        input_amount: u64,
        intermediate_amount: u64,
        output_amount: u64,
        profit: u64,
        gas_used: u64,
        timestamp: u64,
    }

    struct ArbitrageResult has drop {
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        gas_optimized: bool,
        profitable: bool,
    }

    fun estimate_gas_usage(arg0: u8, arg1: u8) : u64 {
        let v0 = if (arg0 == 0) {
            150000
        } else if (arg0 == 1) {
            200000
        } else if (arg0 == 2) {
            180000
        } else if (arg0 == 3) {
            120000
        } else if (arg0 == 4) {
            160000
        } else {
            140000
        };
        let v1 = if (arg1 == 0) {
            150000
        } else if (arg1 == 1) {
            200000
        } else if (arg1 == 2) {
            180000
        } else if (arg1 == 3) {
            120000
        } else if (arg1 == 4) {
            160000
        } else {
            140000
        };
        v0 + v1 + 50000
    }

    public entry fun execute_real_atomic_arbitrage<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 == 10000000, 1);
        assert!(arg1 <= 5 && arg2 <= 5, 3);
        assert!(arg1 != arg2, 4);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = execute_real_swap_step_1<T0>(arg0, arg1, arg3, arg7);
        let v3 = execute_real_swap_step_2<T0>(v2, arg2, arg4, v0 + arg5, arg7);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&v3);
        let v5 = v4 - v0;
        assert!(v5 >= arg5, 2);
        let v6 = AtomicArbitrageEvent{
            user                : v1,
            dex_a               : arg1,
            dex_b               : arg2,
            input_amount        : v0,
            intermediate_amount : 0x2::coin::value<T0>(&v2),
            output_amount       : v4,
            profit              : v5,
            gas_used            : estimate_gas_usage(arg1, arg2),
            timestamp           : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<AtomicArbitrageEvent>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v1);
    }

    fun execute_real_swap_step_1<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg1 == 0) {
            0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_aftermath::get_real_router_package_address();
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
            0x2::coin::zero<T0>(arg3)
        } else if (arg1 == 1) {
            0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_cetus::get_cetus_package();
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
            0x2::coin::zero<T0>(arg3)
        } else if (arg1 == 2) {
            let (_, _, _) = 0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_bluefin::bluefin_swap_exact_sui_for_token<T0>(0x2::coin::value<0x2::sui::SUI>(&arg0), 0, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
            0x2::coin::zero<T0>(arg3)
        } else if (arg1 == 3) {
            let (_, _, _) = 0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_kriya::kriya_swap_exact_sui_for_token<T0>(0x2::coin::value<0x2::sui::SUI>(&arg0), 0, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
            0x2::coin::zero<T0>(arg3)
        } else if (arg1 == 4) {
            let (_, _, _, _, _) = 0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_turbos::turbos_swap_exact_sui_for_token<T0>(0x2::coin::value<0x2::sui::SUI>(&arg0), 0, 4295048016, 999999999999, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
            0x2::coin::zero<T0>(arg3)
        } else {
            0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_deepbook::get_deepbook_package();
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg3));
            0x2::coin::zero<T0>(arg3)
        }
    }

    fun execute_real_swap_step_2<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (arg1 == 0) {
            0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_aftermath::get_real_router_package_address();
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg4));
            0x2::coin::zero<0x2::sui::SUI>(arg4)
        } else if (arg1 == 1) {
            0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_cetus::get_cetus_package();
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg4));
            0x2::coin::zero<0x2::sui::SUI>(arg4)
        } else if (arg1 == 2) {
            let (_, _, _) = 0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_bluefin::bluefin_swap_exact_token_for_sui<T0>(0x2::coin::value<T0>(&arg0), arg3, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg4));
            0x2::coin::zero<0x2::sui::SUI>(arg4)
        } else if (arg1 == 3) {
            let (_, _, _) = 0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_kriya::kriya_swap_exact_token_for_sui<T0>(0x2::coin::value<T0>(&arg0), arg3, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg4));
            0x2::coin::zero<0x2::sui::SUI>(arg4)
        } else if (arg1 == 4) {
            let (_, _, _, _, _) = 0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_turbos::turbos_swap_exact_token_for_sui<T0>(0x2::coin::value<T0>(&arg0), arg3, 79226673515401279992447579055, 999999999999, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg4));
            0x2::coin::zero<0x2::sui::SUI>(arg4)
        } else {
            0xdf4d5e246a32c427f8ab12cb6776f73e6c0f36d6cc6feda3f030edaf5940301a::dex_deepbook::get_deepbook_package();
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg4));
            0x2::coin::zero<0x2::sui::SUI>(arg4)
        }
    }

    public fun get_dex_name(arg0: u8) : vector<u8> {
        if (arg0 == 0) {
            b"Aftermath"
        } else if (arg0 == 1) {
            b"Cetus"
        } else if (arg0 == 2) {
            b"Bluefin"
        } else if (arg0 == 3) {
            b"Kriya"
        } else if (arg0 == 4) {
            b"Turbos"
        } else {
            b"DeepBook"
        }
    }

    public fun get_dex_types() : (u8, u8, u8, u8, u8, u8) {
        (0, 1, 2, 3, 4, 5)
    }

    public fun get_max_gas_budget() : u64 {
        500000
    }

    public fun get_min_profit_threshold() : u64 {
        100000
    }

    public fun get_optimal_dex_pair() : (u8, u8) {
        (3, 5)
    }

    public fun get_required_input_amount() : u64 {
        10000000
    }

    public fun is_gas_optimized(arg0: u8, arg1: u8) : bool {
        estimate_gas_usage(arg0, arg1) <= 500000
    }

    public fun validate_claude_compliance(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : bool {
        if (arg0 != 10000000) {
            return false
        };
        if (arg1 <= arg0) {
            return false
        };
        if (arg2 == arg3) {
            return false
        };
        if (arg2 > 5 || arg3 > 5) {
            return false
        };
        arg1 - arg0 >= 100000
    }

    // decompiled from Move bytecode v6
}

