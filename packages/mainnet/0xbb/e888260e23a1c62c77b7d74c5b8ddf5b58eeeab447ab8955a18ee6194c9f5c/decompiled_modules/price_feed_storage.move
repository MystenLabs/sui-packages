module 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::price_feed_storage {
    fun extract(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update) : (u128, u64) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(arg0);
        if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v0)) {
            abort 13835341475879190531
        };
        let v1 = 0x1::option::extract<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&mut v0);
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v1)) {
            abort 13835341488764092419
        };
        let v2 = 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&mut v1);
        assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v2), 13835904451602677767);
        let v3 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(arg0);
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v3)) {
            abort 13835622989510737925
        };
        (scaled_by_exponent(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v2), 0x1::option::extract<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&mut v3)), timestamp_ms(arg0, arg1))
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

    fun blended_price_and_timestamp_ms(arg0: &0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::feed_info_object::FeedInfoObject, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg2: &0x2::clock::Clock) : (u128, u64) {
        let v0 = 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::feed_info_object::roll_start_timestamp_ms(arg0);
        let v1 = 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::feed_info_object::roll_end_timestamp_ms(arg0);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        if (v2 <= v0) {
            return extract(feed_for_id(arg1, 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::feed_info_object::front_feed_id(arg0)), arg1)
        };
        if (v1 <= v2) {
            return extract(feed_for_id(arg1, 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::feed_info_object::next_feed_id(arg0)), arg1)
        };
        let (v3, v4) = extract(feed_for_id(arg1, 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::feed_info_object::front_feed_id(arg0)), arg1);
        let (v5, v6) = extract(feed_for_id(arg1, 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::feed_info_object::next_feed_id(arg0)), arg1);
        let v7 = ((v1 - v2) as u256) * 1000000000000000000 / ((v1 - v0) as u256);
        if (v4 < v6) {
            return (((v7 * (v3 as u256) / 1000000000000000000 + (1000000000000000000 - v7) * (v5 as u256) / 1000000000000000000) as u128), v4)
        };
        (((v7 * (v3 as u256) / 1000000000000000000 + (1000000000000000000 - v7) * (v5 as u256) / 1000000000000000000) as u128), v6)
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
        abort 13835059567110651905
    }

    public fun force_remove_price_feed<T0>(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::PYTH_LAZER_ROLLING>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::PACKAGE, T0>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg3: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage) {
        0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::force_remove_price_feed<T0>(arg3, arg1, arg2, 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::source_id<0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::PYTH_LAZER_ROLLING>(arg0));
    }

    public fun new_price_feed<T0, T1>(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::PYTH_LAZER_ROLLING>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::VENDOR<T0>, T1>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg3: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: &mut 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::feed_info_object::FeedInfoObject, arg5: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg6: vector<u8>, arg7: u64, arg8: &0x2::clock::Clock) {
        0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::assert_version(arg0);
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update(arg5, arg8, arg6);
        new_price_feed_from_update<T0, T1>(arg0, arg1, arg2, arg3, arg4, &v0, arg7, arg8);
    }

    public fun new_price_feed_from_update<T0, T1>(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::PYTH_LAZER_ROLLING>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::VENDOR<T0>, T1>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg3: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: &mut 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::feed_info_object::FeedInfoObject, arg5: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg6: u64, arg7: &0x2::clock::Clock) {
        0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::assert_version(arg0);
        let (v0, v1) = blended_price_and_timestamp_ms(arg4, arg5, arg7);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::new_price_feed<T0, T1, 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::feed_info_object::FeedInfoObject>(arg3, arg1, arg2, 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::source_cap(arg0), arg4, v0, v1, arg6);
    }

    public fun remove_price_feed<T0>(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::PYTH_LAZER_ROLLING>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::VENDOR<T0>, 0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::ADMIN>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg3: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage) {
        0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::remove_price_feed<T0>(arg3, arg1, arg2, 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::source_cap(arg0));
    }

    fun scaled_by_exponent(arg0: u64, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16) : u128 {
        if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&arg1)) {
            let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&arg1);
            if (v0 >= 38) {
                return 0
            };
            return (((arg0 as u256) * 1000000000000000000 / 0x1::u256::pow(10, (v0 as u8))) as u128)
        };
        let v1 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&arg1);
        assert!(v1 <= 20, 13836185617341874185);
        let v2 = (arg0 as u256) * 0x1::u256::pow(10, (v1 as u8)) * 1000000000000000000;
        assert!(v2 <= 340282366920938463463374607431768211455, 13836467118088519691);
        (v2 as u128)
    }

    public fun set_twap_period_ms<T0, T1>(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::PYTH_LAZER_ROLLING>, arg1: &0x4e2df80a5e2fd0392878298c51ce15164222111ccea05504b9291b158f552677::authority::AuthorityCap<0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::authority::VENDOR<T0>, T1>, arg2: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg3: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg4: u64) {
        0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::assert_version(arg0);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::set_twap_period_ms<T0, T1>(arg3, arg1, arg2, 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::source_id<0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::PYTH_LAZER_ROLLING>(arg0), arg4);
    }

    fun to_ms(arg0: u64) : u64 {
        arg0 / 1000
    }

    public fun update_price_feed(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::PYTH_LAZER_ROLLING>, arg1: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg2: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg3: &mut 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::feed_info_object::FeedInfoObject, arg4: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::assert_version(arg0);
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update(arg4, arg6, arg5);
        update_price_feed_from_update(arg0, arg1, arg2, arg3, &v0, arg6);
    }

    public fun update_price_feed_from_update(arg0: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::source::Source<0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::PYTH_LAZER_ROLLING>, arg1: &0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::config::Config, arg2: &mut 0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::PriceFeedStorage, arg3: &mut 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::feed_info_object::FeedInfoObject, arg4: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::Update, arg5: &0x2::clock::Clock) {
        0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::assert_version(arg0);
        let (v0, v1) = blended_price_and_timestamp_ms(arg3, arg4, arg5);
        0xc14d5641833b51691b2ecaea10a3257d375000247a17806e99e2ec095f571a9b::price_feed_storage::update_price_feed<0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::feed_info_object::FeedInfoObject>(arg2, arg1, 0xbbe888260e23a1c62c77b7d74c5b8ddf5b58eeeab447ab8955a18ee6194c9f5c::source::source_cap(arg0), arg3, v0, v1);
    }

    // decompiled from Move bytecode v7
}

