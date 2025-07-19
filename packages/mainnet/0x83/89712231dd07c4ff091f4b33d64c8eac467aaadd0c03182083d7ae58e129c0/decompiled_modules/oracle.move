module 0x8389712231dd07c4ff091f4b33d64c8eac467aaadd0c03182083d7ae58e129c0::oracle {
    struct OracleConfig has key {
        id: 0x2::object::UID,
        tokens: vector<0x1::string::String>,
        pyth_ids: 0x2::table::Table<0x1::string::String, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>,
        max_age_secs: u64,
        test_prices: 0x2::table::Table<0x1::string::String, u128>,
    }

    struct OracleSetId has copy, drop {
        token: 0x1::string::String,
        provider: 0x1::string::String,
        price_id: vector<u8>,
        timestamp: u64,
    }

    public fun get_decimal(arg0: 0x1::string::String, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &OracleConfig, arg3: &0x2::clock::Clock) : u64 {
        if (arg0 == 0x1::string::utf8(b"0000000000000000000000000000000000000000000000000000000000000000::tfbtc::TFBTC")) {
            return 8
        };
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg3, arg2.max_age_secs);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        assert!(0x2::table::contains<0x1::string::String, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&arg2.pyth_ids, arg0), 1);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v1)
    }

    public fun get_price(arg0: 0x1::string::String, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &OracleConfig, arg3: &0x2::clock::Clock) : u128 {
        if (arg0 == 0x1::string::utf8(b"0000000000000000000000000000000000000000000000000000000000000000::tfbtc::TFBTC")) {
            return *0x2::table::borrow<0x1::string::String, u128>(&arg2.test_prices, arg0)
        };
        assert!(0x2::table::contains<0x1::string::String, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&arg2.pyth_ids, arg0), 1);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = *0x2::table::borrow<0x1::string::String, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&arg2.pyth_ids, arg0);
        assert!(&v2 == &v1, 2);
        get_pyth_price(arg1, arg2.max_age_secs, arg3)
    }

    public fun get_pyth_ids(arg0: &mut OracleConfig) : vector<vector<vector<u8>>> {
        let v0 = 0;
        let v1 = vector[vector[]];
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.tokens)) {
            let v2 = *0x1::vector::borrow<0x1::string::String>(&arg0.tokens, v0);
            let v3 = 0x1::vector::empty<vector<u8>>();
            let v4 = &mut v3;
            0x1::vector::push_back<vector<u8>>(v4, *0x1::string::as_bytes(&v2));
            0x1::vector::push_back<vector<u8>>(v4, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(0x2::table::borrow<0x1::string::String, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&arg0.pyth_ids, v2)));
            0x1::vector::push_back<vector<vector<u8>>>(&mut v1, v3);
            v0 = v0 + 1;
        };
        v1
    }

    fun get_pyth_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: u64, arg2: &0x2::clock::Clock) : u128 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg2, arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u128)
    }

    public fun get_value(arg0: u128, arg1: 0x1::string::String, arg2: u8, arg3: u128, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &OracleConfig, arg6: &0x2::clock::Clock) : u128 {
        arg0 * get_price(arg1, arg4, arg5, arg6) * arg3 / 0x1::u128::pow(10, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleConfig{
            id           : 0x2::object::new(arg0),
            tokens       : 0x1::vector::empty<0x1::string::String>(),
            pyth_ids     : 0x2::table::new<0x1::string::String, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(arg0),
            max_age_secs : 120,
            test_prices  : 0x2::table::new<0x1::string::String, u128>(arg0),
        };
        0x2::transfer::share_object<OracleConfig>(v0);
    }

    public(friend) fun set_max_age_secs(arg0: u64, arg1: &mut OracleConfig) {
        arg1.max_age_secs = arg0;
    }

    public(friend) fun set_pyth_oracle(arg0: 0x1::string::String, arg1: vector<u8>, arg2: &mut OracleConfig, arg3: &0x2::clock::Clock) {
        0x2::table::add<0x1::string::String, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut arg2.pyth_ids, arg0, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::from_byte_vec(arg1));
        0x1::vector::push_back<0x1::string::String>(&mut arg2.tokens, arg0);
        let v0 = OracleSetId{
            token     : arg0,
            provider  : 0x1::string::utf8(b"pyth"),
            price_id  : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<OracleSetId>(v0);
    }

    public(friend) fun unset_oracle(arg0: 0x1::string::String, arg1: &mut OracleConfig) {
        assert!(0x2::table::contains<0x1::string::String, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&arg1.pyth_ids, arg0), 2);
        0x2::table::remove<0x1::string::String, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut arg1.pyth_ids, arg0);
        let (v0, v1) = 0x1::vector::index_of<0x1::string::String>(&arg1.tokens, &arg0);
        assert!(v0, 2);
        0x1::vector::remove<0x1::string::String>(&mut arg1.tokens, v1);
    }

    // decompiled from Move bytecode v6
}

