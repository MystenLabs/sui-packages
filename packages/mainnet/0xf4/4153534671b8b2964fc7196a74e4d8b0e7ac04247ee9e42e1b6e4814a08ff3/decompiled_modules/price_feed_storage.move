module 0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::price_feed_storage {
    public fun force_remove_price_feed<T0>(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::source::PYTH_LAZER>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::PACKAGE, T0>, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg3: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage) {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::force_remove_price_feed<T0>(arg3, arg1, arg2, 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::source_id<0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::source::PYTH_LAZER>(arg0));
    }

    public fun new_price_feed<T0, T1>(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::source::PYTH_LAZER>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::VENDOR<T0>, T1>, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg3: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &mut 0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::feed_info_object::FeedInfoObject, arg5: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update(arg5, arg8, arg6);
        new_price_feed_from_update<T0, T1>(arg0, arg1, arg2, arg3, arg4, &v0, arg7);
    }

    public fun remove_price_feed<T0>(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::source::PYTH_LAZER>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg3: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage) {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::remove_price_feed<T0>(arg3, arg1, arg2, 0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::source::source_cap(arg0));
    }

    public fun set_twap_period_ms<T0, T1>(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::source::PYTH_LAZER>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::VENDOR<T0>, T1>, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg3: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: u64) {
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::set_twap_period_ms<T0, T1>(arg3, arg1, arg2, 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::source_id<0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::source::PYTH_LAZER>(arg0), arg4);
    }

    public fun update_price_feed(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::source::PYTH_LAZER>, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg3: &mut 0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::feed_info_object::FeedInfoObject, arg4: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update(arg4, arg6, arg5);
        update_price_feed_from_update(arg0, arg1, arg2, arg3, &v0);
    }

    fun feed_for_id(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg1: u32) : &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds_ref(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0)) {
            let v2 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v0, v1);
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v2) == arg1) {
                return v2
            };
            v1 = v1 + 1;
        };
        abort 13835059296527712257
    }

    public fun new_price_feed_from_update<T0, T1>(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::source::PYTH_LAZER>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::authority::VENDOR<T0>, T1>, arg2: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg3: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg4: &mut 0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::feed_info_object::FeedInfoObject, arg5: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg6: u64) {
        let (v0, v1) = price_and_timestamp_ms(arg4, arg5);
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::new_price_feed<T0, T1, 0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::feed_info_object::FeedInfoObject>(arg3, arg1, arg2, 0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::source::source_cap(arg0), arg4, v0, v1, arg6);
    }

    fun price_and_timestamp_ms(arg0: &0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::feed_info_object::FeedInfoObject, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update) : (u128, u64) {
        let v0 = feed_for_id(arg1, 0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::feed_info_object::feed_id(arg0));
        let v1 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(v0);
        if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v1)) {
            abort 13835341050677428227
        };
        let v2 = 0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v1);
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v2)) {
            abort 13835341063562330115
        };
        let v3 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v2);
        assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v3), 13835904026400915463);
        let v4 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(v0);
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v4)) {
            abort 13835622564308975621
        };
        (scaled_by_exponent(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v3), 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut v4)), timestamp_ms(v0, arg1))
    }

    fun scaled_by_exponent(arg0: u64, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16) : u128 {
        if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&arg1)) {
            return (((arg0 as u256) * 1000000000000000000 / (0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&arg1) as u8)) as u256)) as u128)
        };
        (((arg0 as u256) * (0x1::u64::pow(10, (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&arg1) as u8)) as u256) * 1000000000000000000) as u128)
    }

    fun timestamp_ms(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update) : u64 {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(arg0);
        if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(&v0)) {
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_closed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(&v0))) {
                return to_ms(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg1))
            };
        };
        let v1 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(arg0);
        if (0x1::option::is_none<0x1::option::Option<u64>>(&v1)) {
            return to_ms(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg1))
        };
        let v2 = 0x1::option::extract<0x1::option::Option<u64>>(&mut v1);
        if (0x1::option::is_none<u64>(&v2)) {
            return to_ms(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(arg1))
        };
        to_ms(0x1::option::extract<u64>(&mut v2))
    }

    fun to_ms(arg0: u64) : u64 {
        arg0 / 1000
    }

    public fun update_price_feed_from_update(arg0: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::source::Source<0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::source::PYTH_LAZER>, arg1: &0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::config::Config, arg2: &mut 0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::PriceFeedStorage, arg3: &mut 0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::feed_info_object::FeedInfoObject, arg4: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update) {
        let (v0, v1) = price_and_timestamp_ms(arg3, arg4);
        0xd12806d2dadf2f71bae4f5f0cd2303203137682ef90c047d8a93788ae6da0f18::price_feed_storage::update_price_feed<0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::feed_info_object::FeedInfoObject>(arg2, arg1, 0xf44153534671b8b2964fc7196a74e4d8b0e7ac04247ee9e42e1b6e4814a08ff3::source::source_cap(arg0), arg3, v0, v1);
    }

    // decompiled from Move bytecode v7
}

