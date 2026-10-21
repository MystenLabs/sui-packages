module 0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::price_feed_storage {
    struct PriceUpdate has copy, drop {
        domain: vector<u8>,
        source: 0x2::object::ID,
        storage_id: u32,
        price: u128,
        confidence: u128,
        timestamp_ms: u64,
    }

    fun assert_accepted(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>, arg1: u32, arg2: u128, arg3: u128, arg4: u64, arg5: &vector<u8>, arg6: &vector<u8>, arg7: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::signer_expires_at_ms(arg0, arg5);
        assert!(0x1::option::is_some<u64>(&v1), 13835059129023987713);
        assert!(v0 < 0x1::option::destroy_some<u64>(v1), 13835340608295796739);
        let v2 = price_update_message(arg0, arg1, arg2, arg3, arg4);
        assert!(0x2::ed25519::ed25519_verify(arg6, arg5, &v2), 13835622096157540357);
        assert!(arg2 != 0, 13835903579724316679);
        assert!((arg4 as u128) <= (v0 as u128) + (0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::max_future_drift_ms(arg0) as u128), 13836185067586060297);
        assert!((arg3 as u256) * 10000 <= (arg2 as u256) * (0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::max_confidence_bps(arg0) as u256), 13836466559742771211);
    }

    fun assert_step_within_limit(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg2: u128, arg3: u64) {
        let (v0, v1) = 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed::price_and_timestamp_ms(0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::price_feed(arg1, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::source_id<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>(arg0)));
        if (arg3 <= v1) {
            return
        };
        let v2 = 0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::step_limit(arg0, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::storage_id(arg1));
        assert!(0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::allows(&v2, v0, arg2, arg3 - v1), 13836748120618958861);
    }

    public fun force_remove_price_feed<T0>(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>, arg2: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg3: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage) {
        0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::assert_version(arg0);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::force_remove_price_feed<T0>(arg3, arg1, arg2, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::source_id<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>(arg0));
    }

    public fun force_update_price_feed<T0>(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::PACKAGE, T0>, arg3: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg4: u128, arg5: u128, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock) {
        0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::assert_version(arg0);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_version(arg1);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::assert_is_admin_or_assistant<T0>();
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::assert_package_authority_cap_is_valid<T0>(arg1, arg2);
        assert_accepted(arg0, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::storage_id(arg3), arg4, arg5, arg6, &arg7, &arg8, arg9);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::update_price_feed<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>>(arg3, arg1, 0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::source_cap(arg0), arg0, arg4, arg6);
    }

    public fun new_price_feed<T0, T1>(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, T1>, arg2: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg3: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg4: u128, arg5: u128, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: &0x2::clock::Clock) {
        0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::assert_version(arg0);
        assert_accepted(arg0, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::storage_id(arg3), arg4, arg5, arg6, &arg7, &arg8, arg10);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::new_price_feed<T0, T1, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>>(arg3, arg1, arg2, 0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::source_cap(arg0), arg0, arg4, arg6, arg9);
    }

    public fun price_update_message(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>, arg1: u32, arg2: u128, arg3: u128, arg4: u64) : vector<u8> {
        let v0 = PriceUpdate{
            domain       : b"haneul_oracle::PriceUpdate",
            source       : 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::object_id<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>(arg0),
            storage_id   : arg1,
            price        : arg2,
            confidence   : arg3,
            timestamp_ms : arg4,
        };
        0x2::bcs::to_bytes<PriceUpdate>(&v0)
    }

    public fun remove_price_feed<T0>(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, 0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::ADMIN>, arg2: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg3: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage) {
        0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::assert_version(arg0);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::remove_price_feed<T0>(arg3, arg1, arg2, 0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::source_cap(arg0));
    }

    public fun set_twap_period_ms<T0, T1>(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>, arg1: &0x51076b7060e539d57ed56c18d4fa30563b4c445ff1237e75c4c96937284a51bb::authority::AuthorityCap<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::authority::VENDOR<T0>, T1>, arg2: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg3: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg4: u64) {
        0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::assert_version(arg0);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::set_twap_period_ms<T0, T1>(arg3, arg1, arg2, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::source_id<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>(arg0), arg4);
    }

    public fun update_price_feed(arg0: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>, arg1: &0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::config::Config, arg2: &mut 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::PriceFeedStorage, arg3: u128, arg4: u128, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::assert_version(arg0);
        assert_accepted(arg0, 0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::storage_id(arg2), arg3, arg4, arg5, &arg6, &arg7, arg8);
        assert_step_within_limit(arg0, arg2, arg3, arg5);
        0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::price_feed_storage::update_price_feed<0xc6a884a012a09e872ecadbf09bb5b6168cbc656681827042b863fb87a0e5a039::source::Source<0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::HANEUL>>(arg2, arg1, 0xa9b29161fb4140f1bc4c6fd615cf012d097dfb9a597c5313905365601843d3c7::source::source_cap(arg0), arg0, arg3, arg5);
    }

    // decompiled from Move bytecode v7
}

