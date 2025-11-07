module 0xe0aed388c925287e5a5c9acfa5147103be31c5417ce6128e85c2058e3d4080ee::atomic_arbitrage {
    struct ArbitrageSuccess has copy, drop {
        user: address,
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
        path: vector<u8>,
    }

    struct ArbitrageFailed has copy, drop {
        user: address,
        initial_amount: u64,
        final_amount: u64,
        loss: u64,
        reason: vector<u8>,
    }

    public fun calculate_profit_bps(arg0: u64, arg1: u64) : u64 {
        if (arg1 <= arg0) {
            return 0
        };
        (arg1 - arg0) * 10000 / arg0
    }

    public fun calculate_three_token_profit<T0, T1, T2>(arg0: u64, arg1: u64) : (bool, u64) {
        if (arg1 > arg0) {
            (true, arg1 - arg0)
        } else {
            (false, 0)
        }
    }

    public fun calculate_two_token_profit<T0, T1>(arg0: u64, arg1: u64) : (bool, u64) {
        if (arg1 > arg0) {
            (true, arg1 - arg0)
        } else {
            (false, 0)
        }
    }

    public fun extract_profit<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(arg0);
        assert!(v0 > arg1, 100);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg0, v0 - arg1), arg2)
    }

    public fun get_min_profitable_amount(arg0: u64, arg1: u64) : u64 {
        arg0 + arg0 * arg1 / 10000
    }

    public fun is_profitable(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg1 <= arg0) {
            return false
        };
        arg1 - arg0 >= arg2
    }

    public entry fun validate_and_return<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(&arg0);
        if (v1 <= arg1) {
            let v2 = ArbitrageFailed{
                user           : v0,
                initial_amount : arg1,
                final_amount   : v1,
                loss           : arg1 - v1,
                reason         : b"NO_PROFIT",
            };
            0x2::event::emit<ArbitrageFailed>(v2);
            abort 100
        };
        let v3 = v1 - arg1;
        assert!(v3 >= arg2, 100);
        let v4 = ArbitrageSuccess{
            user           : v0,
            initial_amount : arg1,
            final_amount   : v1,
            profit         : v3,
            path           : b"CROSS_DEX_ARBITRAGE",
        };
        0x2::event::emit<ArbitrageSuccess>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v0);
    }

    public fun validate_profit_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 > arg1, 100);
        assert!(v0 - arg1 >= arg2, 100);
        arg0
    }

    // decompiled from Move bytecode v6
}

