module 0xb79182d131d9c8530ffe9f1e592af241f63fbcd7bbd0e482cf7c61670f6a8584::guarda {
    public fun suilend_posicao<T0, T1, T2>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u256, arg3: u64) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, arg1);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::borrowed_amount<T0, T1>(v0)) >= arg2, 1);
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposited_ctoken_amount<T0, T2>(v0) >= arg3, 1);
    }

    // decompiled from Move bytecode v7
}

