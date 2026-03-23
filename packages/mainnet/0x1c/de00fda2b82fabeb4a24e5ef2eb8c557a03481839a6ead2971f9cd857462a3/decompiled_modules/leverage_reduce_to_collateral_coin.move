module 0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::LeverageApp, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_obligation::LeverageMarketOwnerCap, arg4: u64, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::ensure_version_matches(arg0);
        0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_obligation::ensure_same_market<T0>(arg3);
        0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let v0 = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_obligation::market_obligation(arg3), arg7, 0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg2, arg3, arg4), arg5, arg6, arg8);
        0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v0), 0, 0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v0
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::LeverageApp, arg1: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::app::ProtocolApp, arg2: &mut 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::market::Market<T0>, arg3: &0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: &0x144c57d6014488bc71c0902bddff482af090d13e2c61333ed903fe088220a92c::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_app::ensure_version_matches(arg0);
        0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_obligation::ensure_same_market<T0>(arg3);
        0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let (v0, _) = 0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg2, arg3, arg4);
        let v2 = 0xfe1d8929d13b00aaecd7642dec1c6d41cab82882a1b139efa46bf61dfd6380bf::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_obligation::market_obligation(arg3), arg7, v0, arg5, arg6, arg8);
        0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v2), 0, 0x1cde00fda2b82fabeb4a24e5ef2eb8c557a03481839a6ead2971f9cd857462a3::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v2
    }

    // decompiled from Move bytecode v6
}

