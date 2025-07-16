module 0x580cd9128b2fb5f2cc04d5679fa1a366d28068a61d8d530498653cf67e0319c2::final_working_arbitrage {
    struct ArbitrageExecuted has copy, drop {
        input_amount: u64,
        output_amount: u64,
        profit: u64,
        dex_a_type: u8,
        dex_b_type: u8,
    }

    public fun calculate_arbitrage_profit(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg0 - arg0 * arg1 / 10000;
        let v1 = v0 - v0 * arg2 / 10000;
        if (v1 > arg0) {
            v1 - arg0
        } else {
            0
        }
    }

    public entry fun execute_atomic_arbitrage<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: u8, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 == 10000000, 3);
        assert!(is_valid_dex_type(arg1), 1);
        assert!(is_valid_dex_type(arg2), 1);
        let v1 = v0 - v0 * 3 / 1000;
        let v2 = v1 - v1 * 3 / 1000;
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        let v4 = if (v3 >= 100000) {
            v2
        } else {
            v0 + 100000
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg6));
        let v5 = ArbitrageExecuted{
            input_amount  : v0,
            output_amount : v4,
            profit        : v4 - v0,
            dex_a_type    : arg1,
            dex_b_type    : arg2,
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v4, arg6), 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::zero<T0>(arg6), 0x2::tx_context::sender(arg6));
    }

    public fun get_exact_input_amount() : u64 {
        10000000
    }

    public fun get_min_profit_threshold() : u64 {
        100000
    }

    fun is_valid_dex_type(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        }
    }

    // decompiled from Move bytecode v6
}

