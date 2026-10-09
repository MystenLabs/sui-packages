module 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::index_oracle {
    public(friend) fun from_index(arg0: u256, arg1: u64) : 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::OraclePrice {
        assert!(arg0 < 57896044618658097711785492504343953926634992332820282019728792003956564819968, 202);
        let v0 = arg0 / 1000000000;
        assert!(v0 > 0, 202);
        0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::new(v0, 0, arg1)
    }

    public(friend) fun read<T0>(arg0: &0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>, arg1: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID) : 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle::OraclePrice {
        assert!(0x2::object::id<0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::ClearingHouse<T0>>(arg0) == arg3, 200);
        assert!(0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_pause_mode<T0>(arg0) == 0 && !0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::is_frozen<T0>(arg0), 201);
        let v0 = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::clearing_house::market_params<T0>(arg0);
        let (v1, v2) = 0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::base_oracle_price_and_twap_price(v0, arg1, arg2);
        0x3ec740df8428aa9c93aaef7f8cc1542ac3194fd014826b51bfe245346d64efc7::market::assert_index_twap_divergence_within_limit(v0, v1, v2);
        from_index(v1, 0x2::clock::timestamp_ms(arg2) / 1000)
    }

    // decompiled from Move bytecode v7
}

