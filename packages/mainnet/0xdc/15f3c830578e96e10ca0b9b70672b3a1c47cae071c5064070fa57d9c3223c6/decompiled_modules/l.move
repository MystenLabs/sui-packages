module 0xdc15f3c830578e96e10ca0b9b70672b3a1c47cae071c5064070fa57d9c3223c6::l {
    fun dispose_residue<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun nl<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg7: 0x2::balance::Balance<T0>, arg8: address, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg7, arg5, arg6, arg8, arg9, arg10, arg11);
        0x2::coin::destroy_zero<T0>(0x2::coin::from_balance<T0>(v1, arg11));
        v0
    }

    public fun sl<T0, T1, T2>(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        let v0 = 0x2::coin::from_balance<T1>(arg5, arg6);
        let (v1, v2) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::liquidate<T0, T1, T2>(arg0, arg2, arg3, arg4, arg1, &mut v0, arg6);
        dispose_residue<T1>(v0, arg6);
        0x2::coin::into_balance<T2>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T2>(arg0, arg4, arg1, v1, 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T2>>(v2), arg6))
    }

    // decompiled from Move bytecode v6
}

