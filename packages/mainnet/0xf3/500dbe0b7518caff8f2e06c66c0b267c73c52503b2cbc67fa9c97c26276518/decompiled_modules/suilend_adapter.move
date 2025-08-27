module 0xf3500dbe0b7518caff8f2e06c66c0b267c73c52503b2cbc67fa9c97c26276518::suilend_adapter {
    public fun deposit_to_suilend(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0x2::sui::SUI>, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0x2::sui::SUI, 0x2::sui::SUI>> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0x2::sui::SUI, 0x2::sui::SUI>(arg0, arg1, arg3, arg2, arg4)
    }

    public fun withdraw_from_suilend(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0x2::sui::SUI>, arg1: u64, arg2: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0x2::sui::SUI, 0x2::sui::SUI>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0x2::sui::SUI, 0x2::sui::SUI>(arg0, arg1, arg3, arg2, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0x2::sui::SUI, 0x2::sui::SUI>>(), arg4)
    }

    // decompiled from Move bytecode v6
}

