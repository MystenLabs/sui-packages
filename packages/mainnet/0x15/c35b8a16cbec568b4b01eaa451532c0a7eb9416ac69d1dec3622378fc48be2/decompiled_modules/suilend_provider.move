module 0x15c35b8a16cbec568b4b01eaa451532c0a7eb9416ac69d1dec3622378fc48be2::suilend_provider {
    struct SuilendProvider has drop {
        dummy_field: bool,
    }

    fun price_feed_from_market_reserves(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_feed::PriceFeed {
        0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_feed::new(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(1), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg0)), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg1)), 0x2::clock::timestamp_ms(arg2) / 1000, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::zero())
    }

    public fun update_suilend_as_primary<T0, T1, T2>(arg0: &0x15c35b8a16cbec568b4b01eaa451532c0a7eb9416ac69d1dec3622378fc48be2::coin_registry::CoinRegistry, arg1: &mut 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::RedOracle, arg2: &mut 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::UpdatePriceRequest<T1>, arg3: &0x2::clock::Clock, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>) {
        0x15c35b8a16cbec568b4b01eaa451532c0a7eb9416ac69d1dec3622378fc48be2::coin_registry::assert_pool_coin_type<T0, T1>(arg0);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T2, T0>(arg4);
        0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::update_price_feed_as_primary<T1, SuilendProvider>(arg1, arg2, price_feed_from_market_reserves(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::total_supply<T2>(v0)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_supply<T2>(v0), arg3), arg3);
    }

    public fun update_suilend_as_secondary<T0, T1, T2>(arg0: &0x15c35b8a16cbec568b4b01eaa451532c0a7eb9416ac69d1dec3622378fc48be2::coin_registry::CoinRegistry, arg1: &mut 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::RedOracle, arg2: &mut 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::UpdatePriceRequest<T1>, arg3: &0x2::clock::Clock, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>) {
        0x15c35b8a16cbec568b4b01eaa451532c0a7eb9416ac69d1dec3622378fc48be2::coin_registry::assert_pool_coin_type<T0, T1>(arg0);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T2, T0>(arg4);
        0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::update_price_feed_as_secondary<T1, SuilendProvider>(arg1, arg2, price_feed_from_market_reserves(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::total_supply<T2>(v0)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::ctoken_supply<T2>(v0), arg3), arg3);
    }

    // decompiled from Move bytecode v6
}

