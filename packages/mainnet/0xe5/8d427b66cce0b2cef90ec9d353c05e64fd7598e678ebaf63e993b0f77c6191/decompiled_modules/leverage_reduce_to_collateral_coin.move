module 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::Market<T0>, arg1: &mut 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0x1e1e32c7e9b4dd68fe84eb7285005ad5c23099e2e8b215ab32b2facf750029f::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::id(arg1), arg2, 0);
        0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::withdraw::withdraw_as_coin<T0, T1>(arg0, 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::market_obligation(arg1), arg5, 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::market::Market<T0>, arg1: &mut 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0x1e1e32c7e9b4dd68fe84eb7285005ad5c23099e2e8b215ab32b2facf750029f::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1, v2) = 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::id(arg1), v1, v2, 0);
        0xbeb04086025ad90f2baacd186f10f81139d464d4350cb46c1804ff8dd10a2fc8::withdraw::withdraw_as_coin<T0, T1>(arg0, 0xe58d427b66cce0b2cef90ec9d353c05e64fd7598e678ebaf63e993b0f77c6191::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

