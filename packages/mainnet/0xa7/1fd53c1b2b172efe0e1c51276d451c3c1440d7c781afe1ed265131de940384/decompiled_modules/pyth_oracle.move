module 0xa71fd53c1b2b172efe0e1c51276d451c3c1440d7c781afe1ed265131de940384::pyth_oracle {
    struct OracleConfig has drop, store {
        oracle_price_id: vector<u8>,
        oracle_price_decimals: u8,
        token_a_decimals: u8,
        token_b_decimals: u8,
        pool_price_inverted: bool,
    }

    public(friend) fun create_oracle_config(arg0: vector<u8>, arg1: u8, arg2: u8, arg3: u8, arg4: bool) : OracleConfig {
        OracleConfig{
            oracle_price_id       : arg0,
            oracle_price_decimals : arg1,
            token_a_decimals      : arg2,
            token_b_decimals      : arg3,
            pool_price_inverted   : arg4,
        }
    }

    public fun get_oracle_price(arg0: &OracleConfig, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg3, arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(arg0.oracle_price_id == 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2), 115);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3) == (arg0.oracle_price_decimals as u64), 119);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4)
    }

    public fun get_oracle_price_x128(arg0: &OracleConfig, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: &0x2::clock::Clock) : u256 {
        to_bluefin_price(arg0, get_oracle_price(arg0, arg1, arg2, arg3))
    }

    public fun to_bluefin_price(arg0: &OracleConfig, arg1: u64) : u256 {
        if (!arg0.pool_price_inverted) {
            (arg1 as u256) * 0x1::u256::pow(10, arg0.token_b_decimals) * 340282366920938463463374607431768211456 / 0x1::u256::pow(10, arg0.oracle_price_decimals) * 0x1::u256::pow(10, arg0.token_a_decimals)
        } else {
            0x1::u256::pow(10, arg0.oracle_price_decimals) * 0x1::u256::pow(10, arg0.token_b_decimals) * 340282366920938463463374607431768211456 / (arg1 as u256) * 0x1::u256::pow(10, arg0.token_a_decimals)
        }
    }

    // decompiled from Move bytecode v7
}

