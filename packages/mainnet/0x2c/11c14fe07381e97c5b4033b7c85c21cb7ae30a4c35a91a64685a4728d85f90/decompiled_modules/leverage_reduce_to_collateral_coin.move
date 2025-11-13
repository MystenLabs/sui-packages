module 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg1: &mut 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::id(arg1), arg2, 0);
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::market_obligation(arg1), arg5, 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::market::Market<T0>, arg1: &mut 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0xcc225fc85e4be2167573358a32df7a7c2d9bcb745d0581843413688e6f0a8f3e::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1, v2) = 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::id(arg1), v1, v2, 0);
        0x5ba8b0d04af44f1270412cac98ab288e60fcfc449f3bfefbf4db953d32908866::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x2c11c14fe07381e97c5b4033b7c85c21cb7ae30a4c35a91a64685a4728d85f90::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

