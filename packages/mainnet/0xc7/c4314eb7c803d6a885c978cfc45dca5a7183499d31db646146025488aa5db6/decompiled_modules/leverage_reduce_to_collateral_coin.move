module 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::LeverageApp, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: &0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::LeverageMarketOwnerCap, arg4: u64, arg5: &0xb2122b399c78f3f0f9874bdd34fbdda90d3867ebf8972bda97f85218bf0de67::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::ensure_version_matches(arg0);
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::ensure_same_market<T0>(arg3);
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let v0 = 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::market_obligation(arg3), arg7, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg2, arg3, arg4), arg5, arg6, arg8);
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v0), 0, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v0
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::LeverageApp, arg1: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::app::ProtocolApp, arg2: &mut 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::market::Market<T0>, arg3: &0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: &0xb2122b399c78f3f0f9874bdd34fbdda90d3867ebf8972bda97f85218bf0de67::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_app::ensure_version_matches(arg0);
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::ensure_same_market<T0>(arg3);
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let (v0, _) = 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg2, arg3, arg4);
        let v2 = 0x9c5315776987148d59fe717f83684506b27ffd87509cf623b82c1dae7071dbae::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::market_obligation(arg3), arg7, v0, arg5, arg6, arg8);
        0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v2), 0, 0xc7c4314eb7c803d6a885c978cfc45dca5a7183499d31db646146025488aa5db6::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v2
    }

    // decompiled from Move bytecode v6
}

