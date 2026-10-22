module 0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::price_feed_storage {
    public fun force_remove_price_feed<T0>(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::AFTERMATH>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::PACKAGE, T0>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg3: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage) {
        0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::assert_version(arg0);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::force_remove_price_feed<T0>(arg3, arg1, arg2, 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::source_id<0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::AFTERMATH>(arg0));
    }

    public fun new_price_feed<T0, T1>(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::AFTERMATH>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::VENDOR<T0>, T1>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg3: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::feed_info_object::FeedInfoObject, arg5: &0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::verifier::Verifier, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: &0x2::clock::Clock) {
        0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::assert_version(arg0);
        let v0 = 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::verifier::verify_and_parse(arg5, arg6, arg7, arg9);
        new_price_feed_from_update<T0, T1>(arg0, arg1, arg2, arg3, arg4, &v0, arg8);
    }

    public fun remove_price_feed<T0>(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::AFTERMATH>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg3: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage) {
        0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::assert_version(arg0);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::remove_price_feed<T0>(arg3, arg1, arg2, 0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::source_cap(arg0));
    }

    public fun set_twap_period_ms<T0, T1>(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::AFTERMATH>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::VENDOR<T0>, T1>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg3: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: u64) {
        0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::assert_version(arg0);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::set_twap_period_ms<T0, T1>(arg3, arg1, arg2, 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::source_id<0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::AFTERMATH>(arg0), arg4);
    }

    public fun update_price_feed(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::AFTERMATH>, arg1: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg2: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::feed_info_object::FeedInfoObject, arg4: &0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::verifier::Verifier, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::assert_version(arg0);
        let v0 = 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::verifier::verify_and_parse(arg4, arg5, arg6, arg7);
        update_price_feed_from_update(arg0, arg1, arg2, arg3, &v0);
    }

    public fun new_price_feed_from_update<T0, T1>(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::AFTERMATH>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::authority::VENDOR<T0>, T1>, arg2: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg3: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg4: &0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::feed_info_object::FeedInfoObject, arg5: &0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::update::Update, arg6: u64) {
        0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::assert_version(arg0);
        let (v0, v1) = price_and_timestamp_ms(arg4, arg5);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::new_price_feed<T0, T1, 0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::feed_info_object::FeedInfoObject>(arg3, arg1, arg2, 0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::source_cap(arg0), arg4, v0, v1, arg6);
    }

    fun price_and_timestamp_ms(arg0: &0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::feed_info_object::FeedInfoObject, arg1: &0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::update::Update) : (u128, u64) {
        let v0 = 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::update::feed_for_id(arg1, 0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::feed_info_object::feed_id(arg0));
        let (v1, v2) = 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed::price_sign_magnitude(v0);
        assert!(!v1, 13835340573935927297);
        let (v3, v4) = 0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed::exponent_sign_magnitude(v0);
        let v5 = if (0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed::market_session(v0) == 4) {
            0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::update::timestamp_ms(arg1)
        } else {
            0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::feed::timestamp_ms(v0)
        };
        (scaled_by_exponent(v2, v3, v4), v5)
    }

    fun scaled_by_exponent(arg0: u64, arg1: bool, arg2: u16) : u128 {
        if (arg1) {
            if (arg2 >= 38) {
                return 0
            };
            return (((arg0 as u256) * 1000000000000000000 / 0x1::u256::pow(10, (arg2 as u8))) as u128)
        };
        assert!(arg2 <= 20, 13835621928653684739);
        let v0 = (arg0 as u256) * 0x1::u256::pow(10, (arg2 as u8)) * 1000000000000000000;
        assert!(v0 <= 340282366920938463463374607431768211455, 13835903429400330245);
        (v0 as u128)
    }

    public fun update_price_feed_from_update(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::source::Source<0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::AFTERMATH>, arg1: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::config::Config, arg2: &mut 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg3: &0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::feed_info_object::FeedInfoObject, arg4: &0x3d1ef06d5b491e5948fdb90c304b0f51f34ce5db482f66c9c3ad7646dc86d50a::update::Update) {
        0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::assert_version(arg0);
        let (v0, v1) = price_and_timestamp_ms(arg3, arg4);
        0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::update_price_feed<0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::feed_info_object::FeedInfoObject>(arg2, arg1, 0x9a7ba807101da55f7902df1a852813f27178e46d4f163b57b3b027e5aa716d94::source::source_cap(arg0), arg3, v0, v1);
    }

    // decompiled from Move bytecode v7
}

