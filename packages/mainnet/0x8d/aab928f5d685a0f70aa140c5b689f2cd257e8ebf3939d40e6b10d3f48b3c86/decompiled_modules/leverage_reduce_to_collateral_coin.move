module 0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::Market<T0>, arg1: &mut 0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_obligation::id(arg1), arg2, 0);
        0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_obligation::market_obligation(arg1), arg5, 0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::market::Market<T0>, arg1: &mut 0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0x66279de64edf41e924388dbe2e7afdf7eee837d48e7b660bce7f6d6185c63b00::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1, v2) = 0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_obligation::id(arg1), v1, v2, 0);
        0xbd565f17c7f959cc177cc9c3d0d093259e09d6abdf6befdd39c0d5346d71f746::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x8daab928f5d685a0f70aa140c5b689f2cd257e8ebf3939d40e6b10d3f48b3c86::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

