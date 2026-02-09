module 0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg1: &mut 0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0x82b78a855db4069292c5c88118121d52c47c536b08cfbc982df030f6f2d4a538::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_obligation::ensure_same_market<T0>(arg1);
        0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_obligation::id(arg1), arg2, 0, 0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_obligation::get_collateral_price<T1, T2>(arg3, arg4));
        0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_obligation::market_obligation(arg1), arg5, 0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::market::Market<T0>, arg1: &mut 0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0x82b78a855db4069292c5c88118121d52c47c536b08cfbc982df030f6f2d4a538::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_obligation::ensure_same_market<T0>(arg1);
        0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1) = 0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_obligation::id(arg1), v1, 0, 0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_obligation::get_collateral_price<T1, T2>(arg3, arg4));
        0xdbc3efbe03fbfd2cc7747b86e285faa6604701c17ae58bf16a5e8e06452997::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x3c8d90788fa43a63c19a31fd6c2806f5135adc784e7e782075a203ab3b72cc4b::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

