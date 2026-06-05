module 0xd207c083a803c74137d98ba7363799f30db860c7ae4c6278e21a1b95396f6710::lend_suilend {
    public fun liquidate<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        let v0 = 0x2::coin::from_balance<T1>(arg4, arg6);
        let (v1, v2) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5, &mut v0, arg6);
        0xd207c083a803c74137d98ba7363799f30db860c7ae4c6278e21a1b95396f6710::sweep::to_bank<T1>(0x2::coin::into_balance<T1>(v0), arg6);
        0x2::coin::into_balance<T2>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T2>(arg0, arg3, arg5, v1, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v2), arg6))
    }

    // decompiled from Move bytecode v7
}

