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
        let v0 = 0x1::ascii::as_bytes(0x1::type_name::as_string(&arg0));
        let v1 = b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI";
        if (v0 == &v1) {
            9
        } else {
            let v3 = b"5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN";
            if (v0 == &v3) {
                6
            } else {
                let v4 = b"c060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN";
                if (v0 == &v4) {
                    6
                } else {
                    let v5 = b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC";
                    if (v0 == &v5) {
                        6
                    } else {
                        let v6 = b"375f70cf2ae4c00bf37117d0c85a2c71545e6ee05c4a5c7d282cd66a4504b068::usdt::USDT";
                        if (v0 == &v6) {
                            6
                        } else {
                            let v7 = b"960b531667636f39e85867775f52f6b1f220a058c4de786905bdf761e06a56bb::usdy::USDY";
                            if (v0 == &v7) {
                                6
                            } else {
                                let v8 = b"deeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP";
                                if (v0 == &v8) {
                                    6
                                } else {
                                    let v9 = b"356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL";
                                    if (v0 == &v9) {
                                        9
                                    } else {
                                        let v10 = b"3e8e9423d80e1774a7ca128fccd8bf5f1f7753be658c5e645929037f7c819040::lbtc::LBTC";
                                        if (v0 == &v10) {
                                            8
                                        } else {
                                            let v11 = b"aafb102dd0902f5055cadecd687fb5b71ca82ef0e0285d90afde828ec58ca96b::btc::BTC";
                                            if (v0 == &v11) {
                                                8
                                            } else {
                                                let v12 = b"876a4b7bce8aeaef60464c11f4026903e9afacab79b9b142686158aa86560b50::xbtc::XBTC";
                                                assert!(v0 == &v12, 0);
                                                8
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    public fun div_ema_price_numeric_x128(arg0: &ValidatedPythPriceInfo, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) : u256 {
        div_price_numeric_x128_inner(arg0, arg1, arg2, true)
    }

    public fun div_price_numeric_x128(arg0: &ValidatedPythPriceInfo, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) : u256 {
        div_price_numeric_x128_inner(arg0, arg1, arg2, false)
    }

    fun div_price_numeric_x128_inner(arg0: &ValidatedPythPriceInfo, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: bool) : u256 {
        let (v0, v1, v2) = if (arg3) {
            let (v3, v4, v5, v6, v7) = get_ema_price_lo_hi_expo_dec(arg0, arg1);
            let _ = v5;
            let _ = v4;
            (v3, v6, v7)
        } else {
            let (v10, v11, v12, v13, v14) = get_price_lo_hi_expo_dec(arg0, arg1);
            let _ = v12;
            let _ = v11;
            (v10, v13, v14)
        };
        let (v15, v16, v17) = if (arg3) {
            let (v18, v19, v20, v21, v22) = get_ema_price_lo_hi_expo_dec(arg0, arg2);
            let _ = v20;
            let _ = v19;
            (v22, v18, v21)
        } else {
            let (v25, v26, v27, v28, v29) = get_price_lo_hi_expo_dec(arg0, arg2);
            let _ = v27;
            let _ = v26;
            (v29, v25, v28)
        };
        let (v30, v31) = if (v17 + v15 > v1 + v2) {
            (0x1::u64::pow(10, ((v17 + v15 - v1 - v2) as u8)), 1)
        } else {
            (1, 0x1::u64::pow(10, ((v1 + v2 - v17 - v15) as u8)))
        };
        assert!(v16 > 0, 2);
        let v32 = ((v0 as u256) * (v30 as u256) << 128) / (v16 as u256) * (v31 as u256);
        assert!(v32 <= 6277101735386680763835789423207666416102355444464034512895, 2);
        v32
    }

    public fun get_ema_price(arg0: &ValidatedPythPriceInfo, arg1: 0x1::type_name::TypeName) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price {
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_ema_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(0x2::vec_map::get<0x1::type_name::TypeName, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfo>(&arg0.map, &arg1)))
    }

    fun get_ema_price_lo_hi_expo_dec(arg0: &ValidatedPythPriceInfo, arg1: 0x1::type_name::TypeName) : (u64, u64, u64, u64, u64) {
        let v0 = get_ema_price(arg0, arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        (v3, v3 - v1, v3 + v1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v4), (decimals(arg1) as u64))
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
        while (v1 < 0x2::vec_map::length<0x1::type_name::TypeName, 0x2::object::ID>(arg2)) {
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

