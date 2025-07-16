module 0xd3b0928d4272dc52a1434c3e8ccde9d9b89e9f9d4166d565d4a7be64fa8d85d2::atomic_arbitrage {
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
        timestamp: u64,
    }

    public entry fun execute_atomic_arbitrage<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v1 == 10000000, 1);
        assert!(arg5 >= 100000, 2);
        assert!(arg1 != arg2, 3);
        assert!(is_valid_dex_type(arg1), 3);
        assert!(is_valid_dex_type(arg2), 3);
        let v2 = execute_swap_sui_to_token<T0>(arg0, arg1, arg3, arg6, arg7);
        let v3 = 0x2::coin::value<T0>(&v2);
        assert!(v3 > 0, 4);
        let v4 = execute_swap_token_to_sui<T0>(v2, arg2, arg4, arg6, arg7);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&v4);
        assert!(v5 > 0, 4);
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
            timestamp           : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<AtomicArbitrageEvent>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0);
    }

    fun execute_swap_sui_to_token<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = if (arg1 == 0) {
            let v2 = v0 * 30 / 10000;
            if (v0 > v2) {
                v0 - v2
            } else {
                0
            }
        } else if (arg1 == 1) {
            let v3 = v0 * 5 / 10000;
            if (v0 > v3) {
                v0 - v3
            } else {
                0
            }
        } else if (arg1 == 2) {
            let v4 = v0 * 25 / 10000;
            if (v0 > v4) {
                v0 - v4
            } else {
                0
            }
        } else {
            0
        };
        assert!(v1 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
        let v5 = 0x2::balance::zero<T0>();
        let v6 = 0;
        while (v6 < v1) {
            0x2::balance::join<T0>(&mut v5, 0x2::balance::zero<T0>());
            v6 = v6 + 1;
        };
        0x2::coin::from_balance<T0>(v5, arg4)
    }

    fun execute_swap_token_to_sui<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u8, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = if (arg1 == 0) {
            let v2 = v0 * 30 / 10000;
            if (v0 > v2) {
                v0 - v2
            } else {
                0
            }
        } else if (arg1 == 1) {
            let v3 = v0 * 5 / 10000;
            if (v0 > v3) {
                v0 - v3
            } else {
                0
            }
        } else if (arg1 == 2) {
            let v4 = v0 * 25 / 10000;
            if (v0 > v4) {
                v0 - v4
            } else {
                0
            }
        } else {
            0
        };
        assert!(v1 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg4));
        let v5 = 0x2::balance::zero<0x2::sui::SUI>();
        let v6 = 0;
        while (v6 < v1) {
            0x2::balance::join<0x2::sui::SUI>(&mut v5, 0x2::balance::zero<0x2::sui::SUI>());
            v6 = v6 + 1;
        };
        0x2::coin::from_balance<0x2::sui::SUI>(v5, arg4)
    }

    public fun get_exact_input_amount() : u64 {
        10000000
    }

    public fun get_min_profit_threshold() : u64 {
        100000
    }

    fun is_valid_dex_type(arg0: u8) : bool {
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

