module 0xc08a2e7e0f8b52f6e660e022048a872368c58991e4f0535cedb1909c9153da8c::pyth {
    struct PythFeed has drop {
        dummy_field: bool,
    }

    struct PythConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PythConfig has store {
        feed_id: vector<u8>,
        max_confidence: u256,
        max_age_secs: u64,
    }

    struct PythConfigSet has copy, drop {
        oracle: 0x2::object::ID,
        feed_id: vector<u8>,
        max_confidence: u256,
        max_age_secs: u64,
    }

    struct PythConfigRemoved has copy, drop {
        oracle: 0x2::object::ID,
        feed_id: vector<u8>,
        max_confidence: u256,
        max_age_secs: u64,
    }

    public fun add(arg0: &mut 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::Oracle, arg1: &0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_market_authority::MarketCap, arg2: vector<u8>, arg3: u256, arg4: u64) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13835058652282945542);
        assert!(arg3 != 0 && arg4 != 0, 13836466031461990414);
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::add(arg0, arg1, 0x1::type_name::with_defining_ids<PythFeed>());
        let v0 = PythConfigKey{dummy_field: false};
        let v1 = PythConfig{
            feed_id        : arg2,
            max_confidence : arg3,
            max_age_secs   : arg4,
        };
        0x2::dynamic_field::add<PythConfigKey, PythConfig>(0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::uid_mut(arg0, arg1), v0, v1);
        let v2 = PythConfigSet{
            oracle         : 0x2::object::id<0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::Oracle>(arg0),
            feed_id        : arg2,
            max_confidence : arg3,
            max_age_secs   : arg4,
        };
        0x2::event::emit<PythConfigSet>(v2);
    }

    public fun remove(arg0: &mut 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::Oracle, arg1: &0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_market_authority::MarketCap) {
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::remove(arg0, arg1, 0x1::type_name::with_defining_ids<PythFeed>());
        let v0 = PythConfigKey{dummy_field: false};
        let PythConfig {
            feed_id        : v1,
            max_confidence : v2,
            max_age_secs   : v3,
        } = 0x2::dynamic_field::remove<PythConfigKey, PythConfig>(0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::uid_mut(arg0, arg1), v0);
        let v4 = PythConfigRemoved{
            oracle         : 0x2::object::id<0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::Oracle>(arg0),
            feed_id        : v1,
            max_confidence : v2,
            max_age_secs   : v3,
        };
        0x2::event::emit<PythConfigRemoved>(v4);
    }

    public fun report(arg0: &0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::Oracle, arg1: &mut 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::Request, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        assert!(0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::request_oracle_id(arg1) == 0x2::object::id<0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::Oracle>(arg0), 13836184363211620364);
        let v0 = PythConfigKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<PythConfigKey, PythConfig>(0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::uid(arg0), v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v2);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v3) == v1.feed_id, 13835058493369155590);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg2, arg3, v1.max_age_secs);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v4);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5), 13835621473387610122);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5);
        assert!(v6 != 0, 13835621481977544714);
        assert!(v1.max_confidence >= 0x1::u256::div_ceil((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v4) as u256) * 1000000000000000000, (v6 as u256)), 13835340024180572168);
        let v7 = scale_to_wad(v6, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v4));
        assert!(v7 != 0, 13835621512042315786);
        assert!(v7 <= 340282366920938463463374607431768211455, 13837028891221360658);
        let v8 = PythFeed{dummy_field: false};
        0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::report<PythFeed>(arg1, v8, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v4) * 1000, (v7 as u128), 18);
    }

    fun scale_to_wad(arg0: u64, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u256 {
        let v0 = (18 as u64);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg1)) {
            let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&arg1);
            if (v0 >= v2) {
                let v3 = v0 - v2;
                assert!(v3 <= 38, 13836747712597262352);
                (arg0 as u256) * 0x1::u256::pow(10, (v3 as u8))
            } else {
                let v4 = v2 - v0;
                assert!(v4 <= 38, 13836747729777131536);
                (arg0 as u256) / 0x1::u256::pow(10, (v4 as u8))
            }
        } else {
            let v5 = v0 + 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&arg1);
            assert!(v5 <= 38, 13836747755546935312);
            (arg0 as u256) * 0x1::u256::pow(10, (v5 as u8))
        }
    }

    public fun update_config(arg0: &mut 0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::Oracle, arg1: &0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_market_authority::MarketCap, arg2: u256, arg3: u64) {
        assert!(arg2 != 0 && arg3 != 0, 13836466113066369038);
        let v0 = PythConfigKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<PythConfigKey, PythConfig>(0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::uid_mut(arg0, arg1), v0);
        v1.max_confidence = arg2;
        v1.max_age_secs = arg3;
        let v2 = PythConfigSet{
            oracle         : 0x2::object::id<0x47281b94d542d93c94295bab90ac7d3de037ffd7fe907309c71d8b715d8c3788::su_oracle::Oracle>(arg0),
            feed_id        : v1.feed_id,
            max_confidence : arg2,
            max_age_secs   : arg3,
        };
        0x2::event::emit<PythConfigSet>(v2);
    }

    // decompiled from Move bytecode v7
}

