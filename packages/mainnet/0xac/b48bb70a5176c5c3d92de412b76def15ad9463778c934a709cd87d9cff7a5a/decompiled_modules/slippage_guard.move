module 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::slippage_guard {
    struct ExactInSlippageGuard<phantom T0> {
        owner: address,
        output_before: u64,
        min_output: u64,
    }

    struct ExactInCoinSlippageGuard<phantom T0> {
        owner: address,
        min_output: u64,
    }

    public fun assert_exact_in_coin_min_output<T0>(arg0: &0x2::coin::Coin<T0>, arg1: ExactInCoinSlippageGuard<T0>, arg2: &0x2::tx_context::TxContext) {
        let ExactInCoinSlippageGuard {
            owner      : v0,
            min_output : v1,
        } = arg1;
        assert!(v0 == 0x2::tx_context::sender(arg2), 0);
        assert!(0x2::coin::value<T0>(arg0) >= v1, 2);
    }

    public fun assert_exact_in_min_output<T0>(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg1: ExactInSlippageGuard<T0>, arg2: &0x2::tx_context::TxContext) {
        let ExactInSlippageGuard {
            owner         : v0,
            output_before : v1,
            min_output    : v2,
        } = arg1;
        assert!(v0 == 0x2::tx_context::sender(arg2), 0);
        let v3 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::holding_token_amount_by_address<T0>(arg0, v0);
        assert!(v3 >= v1, 1);
        assert!(v3 - v1 >= v2, 2);
    }

    public fun begin_exact_in<T0>(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::PointTokenMarket<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) : ExactInSlippageGuard<T0> {
        ExactInSlippageGuard<T0>{
            owner         : 0x2::tx_context::sender(arg2),
            output_before : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token::holding_token_amount_by_address<T0>(arg0, 0x2::tx_context::sender(arg2)),
            min_output    : arg1,
        }
    }

    public fun begin_exact_in_coin<T0>(arg0: u64, arg1: &0x2::tx_context::TxContext) : ExactInCoinSlippageGuard<T0> {
        ExactInCoinSlippageGuard<T0>{
            owner      : 0x2::tx_context::sender(arg1),
            min_output : arg0,
        }
    }

    // decompiled from Move bytecode v7
}

