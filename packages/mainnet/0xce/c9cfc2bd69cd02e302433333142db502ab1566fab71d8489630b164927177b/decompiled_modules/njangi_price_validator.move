module 0xcec9cfc2bd69cd02e302433333142db502ab1566fab71d8489630b164927177b::njangi_price_validator {
    fun calculate_usd_value(arg0: u64, arg1: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg2: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64, arg3: 0x1::ascii::String) : u64 {
        let v0 = 0x1::string::utf8(0x1::ascii::into_bytes(arg3));
        let v1 = 0x1::string::utf8(b"USDC");
        let v2 = if (0x1::string::index_of(&v0, &v1) != 18446744073709551615) {
            true
        } else {
            let v3 = 0x1::string::utf8(b"USDT");
            0x1::string::index_of(&v0, &v3) != 18446744073709551615
        };
        if (v2) {
            arg0 * 1000000 / (10 ^ (get_coin_decimals(v0) as u64) - 6)
        } else {
            arg0 * 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&arg1) / (10 ^ (get_coin_decimals(v0) as u64) + 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&arg2) - 6)
        }
    }

    fun get_coin_decimals(arg0: 0x1::string::String) : u8 {
        let v0 = 0x1::string::utf8(b"USDC");
        if (0x1::string::index_of(&arg0, &v0) != 18446744073709551615) {
            6
        } else {
            let v2 = 0x1::string::utf8(b"USDT");
            if (0x1::string::index_of(&arg0, &v2) != 18446744073709551615) {
                6
            } else {
                let v3 = 0x1::string::utf8(b"ETH");
                if (0x1::string::index_of(&arg0, &v3) != 18446744073709551615) {
                    18
                } else {
                    let v4 = 0x1::string::utf8(b"SUI");
                    if (0x1::string::index_of(&arg0, &v4) != 18446744073709551615) {
                        9
                    } else {
                        let v5 = 0x1::string::utf8(b"AFSUI");
                        if (0x1::string::index_of(&arg0, &v5) != 18446744073709551615) {
                            9
                        } else {
                            9
                        }
                    }
                }
            }
        }
    }

    fun validate_price_id(arg0: vector<u8>, arg1: 0x1::ascii::String) {
        let v0 = 0x1::string::utf8(0x1::ascii::into_bytes(arg1));
        let v1 = 0x1::string::utf8(b"USDC");
        if (0x1::string::index_of(&v0, &v1) != 18446744073709551615) {
            assert!(arg0 == x"eaa020c61cc479712813461ce153894a96a6c00b21ed0cfc2798d1f9a9e9c94a", 101);
        } else {
            let v2 = 0x1::string::utf8(b"USDT");
            if (0x1::string::index_of(&v0, &v2) != 18446744073709551615) {
                assert!(arg0 == x"2b89b9dc8fdf9f34709a5b106b472f0f39bb6ca9ce04b0fd7f2e971688e2e53b", 101);
            } else {
                let v3 = 0x1::string::utf8(b"ETH");
                if (0x1::string::index_of(&v0, &v3) != 18446744073709551615) {
                    assert!(arg0 == x"ff61491a931112ddf1bd8147cd1b641375f79f5825126d665480874634fd0ace", 101);
                } else {
                    let v4 = 0x1::string::utf8(b"SUI");
                    if (0x1::string::index_of(&v0, &v4) != 18446744073709551615) {
                        assert!(arg0 == x"5450dc9536f233ea863ce9f89191a6f755f80e393ba2be2057dbabda0cc407c9", 101);
                    } else {
                        let v5 = 0x1::string::utf8(b"AFSUI");
                        assert!(0x1::string::index_of(&v0, &v5) != 18446744073709551615, 101);
                        assert!(arg0 == x"d213e2929116af56c3ce71a1acee874f1dd03f42567b552085fa9d8ce8ce7134", 101);
                    };
                };
            };
        };
    }

    public fun validate_stablecoin_deposit(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: u64, arg3: 0x1::ascii::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 60;
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg4, v0);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg5) / 1000 - 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v1) <= v0, 102);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v2);
        validate_price_id(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v3), arg3);
        let v4 = calculate_usd_value(arg1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v1), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1), arg3);
        assert!(v4 >= arg2, 103);
        v4
    }

    // decompiled from Move bytecode v6
}

