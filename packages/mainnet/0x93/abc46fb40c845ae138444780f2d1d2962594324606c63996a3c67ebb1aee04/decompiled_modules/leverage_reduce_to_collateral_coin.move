module 0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg1: &mut 0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_obligation::id(arg1), arg2, 0);
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_obligation::market_obligation(arg1), arg5, 0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::market::Market<T0>, arg1: &mut 0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1, v2) = 0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_obligation::id(arg1), v1, v2, 0);
        0xacbb0ff390420ba37e097f110e2fa5d63e647a42545c1643789f223c8b086aed::withdraw::withdraw_as_coin<T0, T1>(arg0, 0x5ee2109070d7a37c652950c4be4186143716ece315e23f57db29d938bed54746::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

