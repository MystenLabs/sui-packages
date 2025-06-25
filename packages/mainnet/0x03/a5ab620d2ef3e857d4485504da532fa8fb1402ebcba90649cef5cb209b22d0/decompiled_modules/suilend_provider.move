module 0x3a5ab620d2ef3e857d4485504da532fa8fb1402ebcba90649cef5cb209b22d0::suilend_provider {
    struct SuilendProvider has drop {
        dummy_field: bool,
    }

    fun price_feed_from_market_reserves(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : 0x160a762164961bb23e641317c84a4a7d65f855124b545ba8c8522341a2cd31ba::price_feed::PriceFeed {
        0x160a762164961bb23e641317c84a4a7d65f855124b545ba8c8522341a2cd31ba::price_feed::new(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(1), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg0)), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg1)), 0x2::clock::timestamp_ms(arg2) / 1000, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::zero())
    }

    public fun update_suilend_as_primary<T0, T1, T2>(arg0: &mut 0x160a762164961bb23e641317c84a4a7d65f855124b545ba8c8522341a2cd31ba::red_oracle::RedOracle, arg1: &mut 0x160a762164961bb23e641317c84a4a7d65f855124b545ba8c8522341a2cd31ba::red_oracle::UpdatePriceRequest<T0>, arg2: &0x2::clock::Clock, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T2, T1>(arg3);
        0x160a762164961bb23e641317c84a4a7d65f855124b545ba8c8522341a2cd31ba::red_oracle::update_price_feed_as_primary<T0, SuilendProvider>(arg0, arg1, price_feed_from_market_reserves(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::total_supply<T2>(v0)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_supply<T2>(v0), arg2), arg2);
    }

    public fun update_suilend_as_secondary<T0, T1, T2>(arg0: &mut 0x160a762164961bb23e641317c84a4a7d65f855124b545ba8c8522341a2cd31ba::red_oracle::RedOracle, arg1: &mut 0x160a762164961bb23e641317c84a4a7d65f855124b545ba8c8522341a2cd31ba::red_oracle::UpdatePriceRequest<T0>, arg2: &0x2::clock::Clock, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>) {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T2, T1>(arg3);
        0x160a762164961bb23e641317c84a4a7d65f855124b545ba8c8522341a2cd31ba::red_oracle::update_price_feed_as_secondary<T0, SuilendProvider>(arg0, arg1, price_feed_from_market_reserves(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::total_supply<T2>(v0)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_supply<T2>(v0), arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

