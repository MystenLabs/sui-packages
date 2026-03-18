module 0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::LeverageApp, arg1: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg2: &mut 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::market::Market<T0>, arg3: &0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_obligation::LeverageMarketOwnerCap, arg4: u64, arg5: &0xd070a524ea5e57221eace4cf821a0133a850f0d4bb01a9d75184fdb75168cb62::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::ensure_version_matches(arg0);
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_obligation::ensure_same_market<T0>(arg3);
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let v0 = 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_obligation::market_obligation(arg3), arg7, 0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg2, arg3, arg4), arg5, arg6, arg8);
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v0), 0, 0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v0
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::LeverageApp, arg1: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::app::ProtocolApp, arg2: &mut 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::market::Market<T0>, arg3: &0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_obligation::LeverageMarketOwnerCap, arg4: u8, arg5: &0xd070a524ea5e57221eace4cf821a0133a850f0d4bb01a9d75184fdb75168cb62::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::coin_decimals_registry::CoinDecimalsRegistry, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_app::ensure_version_matches(arg0);
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_obligation::ensure_same_market<T0>(arg3);
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_obligation::ensure_coins_match<T1, T2>(arg3);
        let (v0, _) = 0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg2, arg3, arg4);
        let v2 = 0x4956d9b3e4d709a682bf9b937b660de620e960de6d4d1ea05fff9f644158e041::withdraw::withdraw_as_coin<T0, T1>(arg1, arg2, 0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_obligation::market_obligation(arg3), arg7, v0, arg5, arg6, arg8);
        0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_obligation::id(arg3), 0x2::coin::value<T1>(&v2), 0, 0x61f31fed814ce72818897dc0d488e16b1065d3dd3c7e36ab63572d7c1a678606::leverage_obligation::get_collateral_price<T1, T2>(arg5, arg6));
        v2
    }

    // decompiled from Move bytecode v6
}

