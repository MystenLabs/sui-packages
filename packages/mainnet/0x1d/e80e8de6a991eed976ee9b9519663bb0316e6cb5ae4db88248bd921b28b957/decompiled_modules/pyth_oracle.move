module 0x1de80e8de6a991eed976ee9b9519663bb0316e6cb5ae4db88248bd921b28b957::pyth_oracle {
    struct OracleConfig has drop, store {
        oracle_price_id: vector<u8>,
        oracle_price_a2b: bool,
        oracle_price_decimals: u8,
        token_a_decimals: u8,
        token_b_decimals: u8,
    }

    public(friend) fun create_oracle_config(arg0: vector<u8>, arg1: bool, arg2: u8, arg3: u8, arg4: u8) : OracleConfig {
        OracleConfig{
            oracle_price_id       : arg0,
            oracle_price_a2b      : arg1,
            oracle_price_decimals : arg2,
            token_a_decimals      : arg3,
            token_b_decimals      : arg4,
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

    public fun get_oracle_price_x128(arg0: &OracleConfig, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) : u256 {
        to_bluefin_price(arg0, arg3, get_oracle_price(arg0, arg1, arg2, arg4))
    }

    public fun is_a2b(arg0: &OracleConfig) : bool {
        arg0.oracle_price_a2b
    }

    public fun to_bluefin_price(arg0: &OracleConfig, arg1: bool, arg2: u64) : u256 {
        if (arg1 == arg0.oracle_price_a2b) {
            (arg2 as u256) * 0x1::u256::pow(10, arg0.token_a_decimals) * 340282366920938463463374607431768211456 / 0x1::u256::pow(10, arg0.oracle_price_decimals) * 0x1::u256::pow(10, arg0.token_b_decimals)
        } else {
            0x1::u256::pow(10, arg0.oracle_price_decimals) * 0x1::u256::pow(10, arg0.token_b_decimals) * 340282366920938463463374607431768211456 / (arg2 as u256) * 0x1::u256::pow(10, arg0.token_a_decimals)
        }
    }

    // decompiled from Move bytecode v7
}

