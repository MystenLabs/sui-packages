module 0x54fe0552081e85db337c852169a560c05a0eef6db7f60c063243064b5b4d9bf0::mf031edd0e5d1cd5d18a45134 {
    public fun f506793ac53193cddcd66eabe<T0, T1>(arg0: &0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T0, T1>, arg1: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T1>, arg2: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T1>, arg3: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T1>, arg4: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T0, T1>, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg7: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg8: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::restore_margin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    // decompiled from Move bytecode v7
}

