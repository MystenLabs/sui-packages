module 0x3633ad6dbbc1550b5e9a1182d2a5de01b68a46077ec9dd6b3a7a4fea8e44f564::pplx {
    public fun b<T0, T1, T2>(arg0: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: 0x2::coin::Coin<T2>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::buy<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, 1, deadline(arg15), arg15, arg16);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T2>(v0);
        let (v2, v3) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::withdraw<T0, T1, T2>(arg0, arg1, v1, arg15, arg16);
        0x60931bd2c8aefe6a52bb66524e4db2bf2ca73f88d989b5d0d409e4f0cd0e189::q::tdc<T2>(v3, arg16);
        v2
    }

    fun deadline(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) + 120000
    }

    public fun s<T0, T1, T2>(arg0: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::CompositePool<T0, T1, T2>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: &mut 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::engine::Engine<T1, T2>, arg3: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg4: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg5: 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T2>, arg6: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg7: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T1>, arg8: &mut 0x67e9a229946236383e6a84a01f185be9b244e4056ff398d7a39d60a19bd2d8dd::yield_adapter::Sleeve<T1, T2>, arg9: &0xbf32cfba21310ac40b05d7269f789270c04aae036ab863dc340c3df3d023fd37::custody::Vault<T2>, arg10: &mut 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::account::Account<T2>, arg11: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::registry::Registry, arg12: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg13: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg14: 0x2::coin::Coin<T0>, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::sell<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::composite_pool::deposit<T0, T1, T2>(arg0, arg1, arg14, arg15, arg16), false, false, 1, deadline(arg15), arg15, arg16);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::share<T2>(v0);
        v1
    }

    public fun sb<T0, T1>(arg0: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::Pool<T0, T1>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::withdraw<T0, T1>(arg0, arg1, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::buy<T0, T1>(arg0, arg1, arg2, 1, deadline(arg3), arg3, arg4), arg3, arg4);
        0x60931bd2c8aefe6a52bb66524e4db2bf2ca73f88d989b5d0d409e4f0cd0e189::q::tdc<T1>(v1, arg4);
        v0
    }

    public fun ss<T0, T1>(arg0: &mut 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::Pool<T0, T1>, arg1: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::sell<T0, T1>(arg0, arg1, 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::pool::deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4), 1, deadline(arg3), arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

