module 0x65aee257361d076c660c17379a47d4d3c3a84d781172b36a141f2410a0d7a467::suilend_provider {
    struct SuilendProvider has drop {
        dummy_field: bool,
    }

    fun price_feed_from_market_reserves(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::PriceFeed {
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price_feed::new(0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::price::new(0x1573ae1086d9b62cf34044f626d9dfcc910dae7c0db9e2d951edde75b0c7847a::u128::mul_div(100000000, (arg0 as u128), (arg1 as u128)), 8, true), 0x2::clock::timestamp_ms(arg2) / 1000, 0)
    }

    public fun update_suilend_as_primary<T0, T1, T2>(arg0: &mut 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::XOracle, arg1: &mut 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::UpdatePriceRequest, arg2: &0x2::clock::Clock, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T2, T1>(arg3);
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::update_price_feed_as_primary<T0, SuilendProvider>(arg0, arg1, price_feed_from_market_reserves(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::total_supply<T2>(v0)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_supply<T2>(v0), arg2), arg2);
    }

    public fun update_suilend_as_secondary<T0, T1, T2>(arg0: &mut 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::XOracle, arg1: &mut 0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::UpdatePriceRequest, arg2: &0x2::clock::Clock, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T2, T1>(arg3);
        0x69090d95875d05f8754dd2cc7b94fbdec0495bff926c8c669ffd07b83f7da57d::x_oracle::update_price_feed_as_secondary<T0, SuilendProvider>(arg0, arg1, price_feed_from_market_reserves(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::total_supply<T2>(v0)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_supply<T2>(v0), arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

