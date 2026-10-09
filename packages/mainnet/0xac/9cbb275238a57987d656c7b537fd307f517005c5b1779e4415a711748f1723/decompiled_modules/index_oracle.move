module 0xac9cbb275238a57987d656c7b537fd307f517005c5b1779e4415a711748f1723::index_oracle {
    public(friend) fun from_feed(arg0: u128, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : 0xac9cbb275238a57987d656c7b537fd307f517005c5b1779e4415a711748f1723::oracle::OraclePrice {
        assert!(arg3 <= arg2 || arg3 - arg2 <= arg4 * 1000, 201);
        let v0 = (arg0 as u256) / 1000000000;
        assert!(v0 > 0, 202);
        let v1 = if (arg1 == 0) {
            v0
        } else {
            (arg1 as u256) / 1000000000
        };
        let v2 = if (v0 > v1) {
            v0 - v1
        } else {
            v1 - v0
        };
        assert!(v2 * 10000 <= v0 * (arg5 as u256), 203);
        0xac9cbb275238a57987d656c7b537fd307f517005c5b1779e4415a711748f1723::oracle::new(v0, v2, arg2 / 1000)
    }

    public(friend) fun read(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: u16, arg4: u64, arg5: u64) : 0xac9cbb275238a57987d656c7b537fd307f517005c5b1779e4415a711748f1723::oracle::OraclePrice {
        assert!(0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg0) == arg2, 200);
        assert!(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::contains(arg0, arg3), 204);
        let v0 = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg0, arg3);
        from_feed(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::price(v0), 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::twap_price(v0), 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::timestamp_ms(v0), 0x2::clock::timestamp_ms(arg1), arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

