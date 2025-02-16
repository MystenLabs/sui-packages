module 0x10796f703ad15da54343e5e9aff0c7e3eb1d7b5f68edebf77b0d0a8bf5171a4a::lp_rewards {
    struct LP_REWARDS has drop {
        dummy_field: bool,
    }

    public fun create_reserve<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarketOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::coin::CoinMetadata<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::add_reserve<T0, T1>(arg0, arg1, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::create_reserve_config(70, 75, 75, 18446744073709551615, 80000000000000000, 0, 300, 300, 500000000, 0, 30, 2000, 199, x"0000", vector[0, 0], false, 0, 0, arg5), arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

