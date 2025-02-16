module 0x8f0c7ac0aaabb7bbbb2016bfce6897340bb9772d82ad7bc345e17543a8fe9ce4::lp_rewards {
    struct LP_REWARDS has drop {
        dummy_field: bool,
    }

    public fun create_lending_market(arg0: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market_registry::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market_registry::create_lending_market<LP_REWARDS>(arg0, arg1);
        0x2::transfer::public_transfer<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarketOwnerCap<LP_REWARDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<LP_REWARDS>>(v1);
    }

    public fun create_reserve<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarketOwnerCap<T0>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::coin::CoinMetadata<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::add_reserve<T0, T1>(arg0, arg1, arg2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::create_reserve_config(70, 75, 75, 18446744073709551615, 80000000000000000, 0, 300, 300, 500000000, 0, 30, 2000, 199, x"0000", vector[0, 0], true, 0, 0, arg5), arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

