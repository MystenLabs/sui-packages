module 0xb587ebf141a03d98a8c7b034315c30dda6e524c3dcbddcb828c1ca1cafeb1ba5::hawk_suilend {
    entry fun liquidate_and_redeem<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg0, arg1, arg2, arg3, arg6, &mut arg4, arg7);
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T2>(arg0, arg3, arg6, v0, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v1), arg7);
        assert!(0x2::coin::value<T2>(&v2) >= arg5, 1);
        if (0x2::coin::value<T1>(&arg4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T1>(arg4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v2, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

