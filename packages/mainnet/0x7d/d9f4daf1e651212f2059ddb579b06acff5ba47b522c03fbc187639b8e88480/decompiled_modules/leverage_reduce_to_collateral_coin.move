module 0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg1: &mut 0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_obligation::id(arg1), arg2, 0);
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_obligation::market_obligation(arg1), arg5, 0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::market::Market<T0>, arg1: &mut 0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0x32467102bea06f74441ca645b1fc52019ba0c3103bb9e693d85010acd617dac7::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1, v2) = 0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_obligation::id(arg1), v1, v2, 0);
        0xa8b33a54e49cc6c9f43044b81630ea086cdbf68862000a72720c5994e5da90ee::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x7dd9f4daf1e651212f2059ddb579b06acff5ba47b522c03fbc187639b8e88480::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

