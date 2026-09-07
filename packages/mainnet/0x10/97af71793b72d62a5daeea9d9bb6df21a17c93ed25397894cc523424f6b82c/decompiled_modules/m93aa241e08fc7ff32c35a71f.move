module 0x1097af71793b72d62a5daeea9d9bb6df21a17c93ed25397894cc523424f6b82c::m93aa241e08fc7ff32c35a71f {
    public fun f429a8bdaeb03d6e9d95cfa1e<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T2>>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun f432fe322e825a9d59af1c1b8<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::refresh_reserve_price<T0>(arg0, arg1, arg2, arg3);
    }

    public fun f746e24d78abc5e3c6fa58eb8<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun fa4fa767b7e6627b1276f8578<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::LiquidityRequest<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun fae169312ef5752e8d847424d<T0, T1>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, arg4: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>, arg5: &mut 0x2::tx_context::TxContext) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::LiquidityRequest<T0, T1> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun ff326b21eb76f4e88650b99cd<T0>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: u64, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::LiquidityRequest<T0, 0x2::sui::SUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

