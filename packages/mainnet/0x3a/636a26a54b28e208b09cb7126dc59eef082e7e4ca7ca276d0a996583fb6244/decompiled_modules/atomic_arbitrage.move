module 0x3a636a26a54b28e208b09cb7126dc59eef082e7e4ca7ca276d0a996583fb6244::atomic_arbitrage {
    struct AtomicArbitrageEvent has copy, drop {
        user: address,
        input_amount: u64,
        intermediate_amount: u64,
        output_amount: u64,
        profit: u64,
        dex_a: u8,
        dex_b: u8,
        pool_a_id: 0x2::object::ID,
        pool_b_id: 0x2::object::ID,
        success: bool,
        real_addresses: bool,
    }

    public fun calculate_expected_profit(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg0 - arg0 * arg1 / 10000;
        let v1 = v0 - v0 * arg2 / 10000;
        let v2 = v1 + v1 * arg3 / 10000;
        if (v2 > arg0) {
            v2 - arg0
        } else {
            0
        }
    }

    fun execute_aftermath_swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        abort 3
    }

    public entry fun execute_atomic_arbitrage<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 == 10000000, 1);
        assert!(arg5 >= 100000, 2);
        assert!(arg1 != arg2, 4);
        let v2 = execute_swap_sui_to_token<T0>(arg0, arg1, arg3, arg7);
        let v3 = 0x2::coin::value<T0>(&v2);
        assert!(v3 > 0, 3);
        let v4 = execute_swap_token_to_sui<T0>(v2, arg2, arg4, arg7);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        assert!(v5 > 0, 3);
        let v6 = if (v5 > v1) {
            v5 - v1
        } else {
            0
        };
        assert!(v6 >= arg5, 2);
        let v7 = AtomicArbitrageEvent{
            user                : v0,
            input_amount        : v1,
            intermediate_amount : v3,
            output_amount       : v5,
            profit              : v6,
            dex_a               : arg1,
            dex_b               : arg2,
            pool_a_id           : arg3,
            pool_b_id           : arg4,
            success             : true,
            real_addresses      : true,
        };
        0x2::event::emit<AtomicArbitrageEvent>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0);
    }

    fun execute_deepbook_swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        abort 3
    }

    fun execute_swap_sui_to_token<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg1 == 0) {
            execute_deepbook_swap<0x2::sui::SUI, T0>(arg0, arg2, arg3)
        } else if (arg1 == 1) {
            execute_turbos_swap<0x2::sui::SUI, T0>(arg0, arg2, arg3)
        } else {
            assert!(arg1 == 2, 4);
            execute_aftermath_swap<0x2::sui::SUI, T0>(arg0, arg2, arg3)
        }
    }

    fun execute_swap_token_to_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u8, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (arg1 == 0) {
            execute_deepbook_swap<T0, 0x2::sui::SUI>(arg0, arg2, arg3)
        } else if (arg1 == 1) {
            execute_turbos_swap<T0, 0x2::sui::SUI>(arg0, arg2, arg3)
        } else {
            assert!(arg1 == 2, 4);
            execute_aftermath_swap<T0, 0x2::sui::SUI>(arg0, arg2, arg3)
        }
    }

    fun execute_turbos_swap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        abort 3
    }

    public fun get_exact_input_amount() : u64 {
        10000000
    }

    public fun get_min_profit_threshold() : u64 {
        100000
    }

    public fun is_valid_dex_type(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        }
    }

    // decompiled from Move bytecode v6
}

