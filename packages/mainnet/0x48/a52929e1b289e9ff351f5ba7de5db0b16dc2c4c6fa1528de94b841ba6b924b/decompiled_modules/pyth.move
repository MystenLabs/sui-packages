module 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::pyth {
    struct PythPriceInfo has copy, drop {
        pio_map: 0x2::vec_map::VecMap<0x2::object::ID, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>,
        current_ts_sec: u64,
        max_age_secs: u64,
    }

    struct ValidatedPythPriceInfo has copy, drop {
        map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>,
        current_ts_sec: u64,
        max_age_secs: u64,
    }

    public fun add(arg0: &mut PythPriceInfo, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0));
        let v2 = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1);
        if (!0x2::vec_map::contains<0x2::object::ID, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(&arg0.pio_map, &v2)) {
            0x2::vec_map::insert<0x2::object::ID, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(&mut arg0.pio_map, v2, v0);
        };
        arg0.max_age_secs = 0x1::u64::max(arg0.max_age_secs, arg0.current_ts_sec - 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v1));
    }

    public fun create(arg0: &0x2::clock::Clock) : PythPriceInfo {
        PythPriceInfo{
            pio_map        : 0x2::vec_map::empty<0x2::object::ID, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(),
            current_ts_sec : 0x2::clock::timestamp_ms(arg0) / 1000,
            max_age_secs   : 0,
        }
    }

    public fun decimals(arg0: 0x1::type_name::TypeName) : u8 {
        if (arg0 == 0x1::type_name::get<0x2::sui::SUI>()) {
            9
        } else if (arg0 == 0x1::type_name::get<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>()) {
            6
        } else if (arg0 == 0x1::type_name::get<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN>()) {
            6
        } else if (arg0 == 0x1::type_name::get<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()) {
            6
        } else if (arg0 == 0x1::type_name::get<0x375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT>()) {
            6
        } else if (arg0 == 0x1::type_name::get<0x960b531667636f39e85867775f52f6b1f220a058c4de786905bdf761e06a56bb::usdy::USDY>()) {
            6
        } else if (arg0 == 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>()) {
            6
        } else if (arg0 == 0x1::type_name::get<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>()) {
            9
        } else if (arg0 == 0x1::type_name::get<0x3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::lbtc::LBTC>()) {
            8
        } else if (arg0 == 0x1::type_name::get<0xaafb102dd0902f5055cadecd687fb5b71ca82ef0e0285d90afde828ec58ca96b::btc::BTC>()) {
            8
        } else {
            assert!(arg0 == 0x1::type_name::get<0x876a4b7bce8aeaef60464c11f4026903e9afacab79b9b142686158aa86560b50::xbtc::XBTC>(), 0);
            8
        }
    }

    public fun div_price_numeric_x128(arg0: &ValidatedPythPriceInfo, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) : u256 {
        let (v0, _, _, v3, v4) = get_price_lo_hi_expo_dec(arg0, arg1);
        let (v5, _, _, v8, v9) = get_price_lo_hi_expo_dec(arg0, arg2);
        let (v10, v11) = if (v8 + v9 > v3 + v4) {
            (0x1::u64::pow(10, ((v8 + v9 - v3 - v4) as u8)), 1)
        } else {
            (1, 0x1::u64::pow(10, ((v3 + v4 - v8 - v9) as u8)))
        };
        assert!(v5 > 0, 2);
        let v12 = ((v0 as u256) * (v10 as u256) << 128) / (v5 as u256) * (v11 as u256);
        assert!(v12 <= 6277101735386680763835789423207666416102355444464034512895, 2);
        v12
    }

    public fun get_ema_price(arg0: &ValidatedPythPriceInfo, arg1: 0x1::type_name::TypeName) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_ema_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(0x2::vec_map::get<0x1::type_name::TypeName, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(&arg0.map, &arg1)))
    }

    public fun get_price(arg0: &ValidatedPythPriceInfo, arg1: 0x1::type_name::TypeName) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(0x2::vec_map::get<0x1::type_name::TypeName, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(&arg0.map, &arg1)))
    }

    fun get_price_lo_hi_expo_dec(arg0: &ValidatedPythPriceInfo, arg1: 0x1::type_name::TypeName) : (u64, u64, u64, u64, u64) {
        let v0 = get_price(arg0, arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        (v3, v3 - v1, v3 + v1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4), (decimals(arg1) as u64))
    }

    public fun max_age_secs(arg0: &ValidatedPythPriceInfo) : u64 {
        arg0.max_age_secs
    }

    public fun validate(arg0: &PythPriceInfo, arg1: u64, arg2: &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::object::ID>) : ValidatedPythPriceInfo {
        assert!(arg0.max_age_secs <= arg1, 1);
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x1::type_name::TypeName, 0x2::object::ID>(arg2)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, 0x2::object::ID>(arg2, v1);
            0x2::vec_map::insert<0x1::type_name::TypeName, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(&mut v0, *v2, *0x2::vec_map::get<0x2::object::ID, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(&arg0.pio_map, v3));
            v1 = v1 + 1;
        };
        ValidatedPythPriceInfo{
            map            : v0,
            current_ts_sec : arg0.current_ts_sec,
            max_age_secs   : arg0.max_age_secs,
        }
    }

    // decompiled from Move bytecode v6
}

