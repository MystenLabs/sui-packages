module 0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::LeverageApp, arg1: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ProtocolApp, arg2: &mut 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>, arg3: &0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_obligation::LeverageMarketOwnerCap, arg4: u64, arg5: &0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::ensure_version_matches(arg0);
        0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_obligation::ensure_same_market<T0>(arg3);
        0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let v0 = 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_obligation::market_obligation(arg3), arg7, 0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg2, arg3, arg4), arg5, arg6, arg8);
        0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v0), 0, 0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v0
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::LeverageApp, arg1: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::app::ProtocolApp, arg2: &mut 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::market::Market<T0>, arg3: &0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: &0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_app::ensure_version_matches(arg0);
        0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_obligation::ensure_same_market<T0>(arg3);
        0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let (v0, _) = 0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg2, arg3, arg4);
        let v2 = 0x9a1a0e74290b944c71a13a09b4587c6ef43067f7539a43c1a6b1a14e6923609b::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_obligation::market_obligation(arg3), arg7, v0, arg5, arg6, arg8);
        0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v2), 0, 0x54f922df2da95336443a9d2763833160050e846c6a9bc12d0ab0eccb5a321984::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v2
    }

    // decompiled from Move bytecode v6
}

