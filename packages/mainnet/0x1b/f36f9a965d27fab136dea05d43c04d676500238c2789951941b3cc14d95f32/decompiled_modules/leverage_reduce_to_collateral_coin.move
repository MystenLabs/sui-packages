module 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::LeverageApp, arg1: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ProtocolApp, arg2: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::Market<T0>, arg3: &0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::LeverageMarketOwnerCap, arg4: u64, arg5: &0x91eff0477a2ed085f95d0e72a83b63e40e7258e3b3dcc7d54554ca4038794463::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::ensure_version_matches(arg0);
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::ensure_same_market<T0>(arg3);
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let v0 = 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::market_obligation(arg3), arg7, 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg2, arg3, arg4), arg5, arg6, arg8);
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v0), 0, 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v0
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::LeverageApp, arg1: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::app::ProtocolApp, arg2: &mut 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::market::Market<T0>, arg3: &0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: &0x91eff0477a2ed085f95d0e72a83b63e40e7258e3b3dcc7d54554ca4038794463::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_app::ensure_version_matches(arg0);
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::ensure_same_market<T0>(arg3);
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let (v0, _) = 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg2, arg3, arg4);
        let v2 = 0x9c5d5dbf497d8eab6b06bb64445b7c7e3c7f0483ae451c2cf83028c9b382473a::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::market_obligation(arg3), arg7, v0, arg5, arg6, arg8);
        0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v2), 0, 0x1bf36f9a965d27fab136dea05d43c04d676500238c2789951941b3cc14d95f32::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v2
    }

    // decompiled from Move bytecode v6
}

