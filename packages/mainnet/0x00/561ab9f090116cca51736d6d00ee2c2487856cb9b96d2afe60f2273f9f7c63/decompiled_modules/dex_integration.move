module 0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::dex_integration {
    struct ArbitrageOpportunity has copy, drop {
        token_pair: vector<u8>,
        source_dex: vector<u8>,
        target_dex: vector<u8>,
        source_price: u64,
        target_price: u64,
        max_amount: u64,
        estimated_profit: u64,
        confidence: u64,
    }

    struct ArbitrageResult has copy, drop {
        opportunity_id: vector<u8>,
        amount_borrowed: u64,
        source_amount_out: u64,
        target_amount_out: u64,
        profit: u64,
        gas_used: u64,
        success: bool,
    }

    struct ArbitrageExecuted has copy, drop {
        pool_id: 0x2::object::ID,
        executor: address,
        token_pair: vector<u8>,
        source_dex: vector<u8>,
        target_dex: vector<u8>,
        amount_borrowed: u64,
        profit_made: u64,
        timestamp: u64,
    }

    struct PriceDiscrepancyDetected has copy, drop {
        token_pair: vector<u8>,
        dex_a: vector<u8>,
        dex_b: vector<u8>,
        price_a: u64,
        price_b: u64,
        potential_profit: u64,
        timestamp: u64,
    }

    public fun calculate_arbitrage_profit(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 <= arg1) {
            return 0
        };
        let v0 = arg0 * (arg2 - arg1) / arg1;
        let v1 = v0 * arg3 / 10000;
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    fun calculate_simulated_profit(arg0: u64) : u64 {
        let v0 = if (arg0 < 1000000000) {
            5
        } else if (arg0 < 10000000000) {
            3
        } else {
            2
        };
        arg0 * v0 / 100
    }

    public fun estimate_arbitrage_gas(arg0: u64, arg1: u64) : u64 {
        1000000 + arg0 * 500000 + arg1 * 200000
    }

    public entry fun execute_arbitrage_entry<T0>(arg0: &mut 0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::flashfi::FlashLoanPool<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = execute_simple_arbitrage<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::flashfi::keep_receipt(v0, arg7);
    }

    public fun execute_multi_hop_arbitrage<T0>(arg0: &mut 0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::flashfi::FlashLoanPool<T0>, arg1: u64, arg2: u64, arg3: vector<vector<u8>>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::flashfi::FlashLoanReceipt {
        let (v0, v1) = 0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::flashfi::borrow<T0>(arg0, arg1, arg6);
        0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::flashfi::repay<T0>(arg0, v1, execute_multi_hop_trades<T0>(v0, arg3, arg2, arg6), arg4, arg5, arg6)
    }

    fun execute_multi_hop_trades<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<vector<u8>>, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 * 2 / 100 >= arg2, 12);
        arg0
    }

    public fun execute_simple_arbitrage<T0>(arg0: &mut 0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::flashfi::FlashLoanPool<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::flashfi::FlashLoanReceipt {
        let (v0, v1) = 0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::flashfi::borrow<T0>(arg0, arg1, arg7);
        0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::flashfi::repay<T0>(arg0, v1, simulate_arbitrage_trades<T0>(v0, arg3, arg4, arg2, arg7), arg5, arg6, arg7)
    }

    public fun execute_triangular_arbitrage<T0, T1, T2>(arg0: &mut 0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::flashfi::FlashLoanPool<T0>, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::flashfi::FlashLoanReceipt {
        let (v0, v1) = 0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::flashfi::borrow<T0>(arg0, arg1, arg5);
        0x561ab9f090116cca51736d6d00ee2c2487856cb9b96d2afe60f2273f9f7c63::flashfi::repay<T0>(arg0, v1, execute_triangular_trades<T0, T1, T2>(v0, arg2, arg5), arg3, arg4, arg5)
    }

    fun execute_triangular_trades<T0, T1, T2>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0) * 3 / 100;
        assert!(v0 >= arg1, 12);
        assert!(v0 >= arg1, 12);
        arg0
    }

    public fun find_arbitrage_opportunities(arg0: vector<vector<u8>>, arg1: vector<vector<u8>>, arg2: u64) : vector<ArbitrageOpportunity> {
        0x1::vector::empty<ArbitrageOpportunity>()
    }

    public fun get_dex_price(arg0: vector<u8>, arg1: vector<u8>) : (u64, u8) {
        if (arg0 == b"CETUS") {
            (1000, 8)
        } else if (arg0 == b"TURBOS") {
            (1000 + 50, 8)
        } else if (arg0 == b"DEEPBOOK") {
            (1000 + 25, 8)
        } else {
            (1000, 8)
        }
    }

    public fun is_arbitrage_profitable(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        calculate_arbitrage_profit(arg0, arg1, arg2, arg3) >= arg0 * arg4 / 10000
    }

    fun simulate_arbitrage_trades<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = calculate_simulated_profit(0x2::coin::value<T0>(&arg0));
        assert!(v0 >= arg3, 12);
        assert!(v0 >= arg3, 12);
        arg0
    }

    // decompiled from Move bytecode v6
}

