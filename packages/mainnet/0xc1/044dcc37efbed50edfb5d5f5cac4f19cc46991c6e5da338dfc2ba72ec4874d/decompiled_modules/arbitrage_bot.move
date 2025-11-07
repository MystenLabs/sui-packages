module 0xc1044dcc37efbed50edfb5d5f5cac4f19cc46991c6e5da338dfc2ba72ec4874d::arbitrage_bot {
    struct CrossDexArbitrageSuccess has copy, drop {
        user: address,
        initial_sui: u64,
        final_sui: u64,
        profit: u64,
        profit_bps: u64,
        path: vector<u8>,
    }

    struct ArbitrageProfitCheckFailed has copy, drop {
        user: address,
        initial_sui: u64,
        final_sui: u64,
        required_amount: u64,
        shortfall: u64,
    }

    public fun calculate_profit_bps(arg0: u64, arg1: u64) : u64 {
        if (arg1 <= arg0) {
            return 0
        };
        (arg1 - arg0) * 10000 / arg0
    }

    public fun calculate_required_amount(arg0: u64, arg1: u64) : u64 {
        arg0 * (10000 + arg1) / 10000
    }

    public entry fun cross_dex_arbitrage<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<T0>(&arg0);
        assert!(v1 > 0, 1);
        assert!(arg1 < 10000, 2);
        let v2 = swap_on_cetus<T0, T1>(arg0, arg2);
        let v3 = swap_on_turbos<T1, T2>(v2, arg2);
        let v4 = swap_on_turbos<T2, T0>(v3, arg2);
        let v5 = 0x2::coin::value<T0>(&v4);
        let v6 = calculate_required_amount(v1, arg1);
        if (v5 < v6) {
            let v7 = ArbitrageProfitCheckFailed{
                user            : v0,
                initial_sui     : v1,
                final_sui       : v5,
                required_amount : v6,
                shortfall       : v6 - v5,
            };
            0x2::event::emit<ArbitrageProfitCheckFailed>(v7);
            abort 0
        };
        let v8 = v5 - v1;
        let v9 = CrossDexArbitrageSuccess{
            user        : v0,
            initial_sui : v1,
            final_sui   : v5,
            profit      : v8,
            profit_bps  : v8 * 10000 / v1,
            path        : b"SUI->USDC->IKA->SUI",
        };
        0x2::event::emit<CrossDexArbitrageSuccess>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v0);
    }

    public fun get_bps_denominator() : u64 {
        10000
    }

    public fun get_max_bps() : u64 {
        10000
    }

    public fun get_min_profit_amount(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    public fun is_profitable(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg1 >= calculate_required_amount(arg0, arg2)
    }

    fun swap_on_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 999
    }

    fun swap_on_turbos<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        abort 999
    }

    // decompiled from Move bytecode v6
}

