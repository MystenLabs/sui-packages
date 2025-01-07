module 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::market_factory {
    struct MarketCreatedEvent has copy, drop {
        marketId: 0x1::string::String,
        factoryConfigId: 0x2::object::ID,
        ptId: 0x2::object::ID,
        expiry: u64,
        scalarRoot: 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::FixedPoint64WithSign,
        initialAnchor: 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::FixedPoint64WithSign,
        lnFeeRateRoot: 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64::FixedPoint64,
    }

    fun calc_market_id<T0>(arg0: &0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::pt::PTStruct<T0>, arg1: 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::FixedPoint64WithSign, arg2: 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::FixedPoint64WithSign) : 0x1::string::String {
        let v0 = 0x2::object::id<0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::pt::PTStruct<T0>>(arg0);
        let v1 = 0x2::object::id_to_bytes(&v0);
        let v2 = 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::get_raw_value(arg1);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u128>(&v2));
        let v3 = 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::get_raw_value(arg2);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u128>(&v3));
        let v4 = 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::get_raw_value(arg3);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u128>(&v4));
        0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::utils::vector_to_hex_string(0x1::hash::sha2_256(v1))
    }

    public fun create_new_market<T0: drop>(arg0: &0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::pt::PTStruct<0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::sy::SYCoin<T0>>, arg1: &mut 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::market_global::MarketFactoryConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg2);
        let v1 = &mut v0;
        let v2 = 0x2::bcs::new(arg3);
        let v3 = &mut v2;
        create_new_market_internal<0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::sy::SYCoin<T0>>(arg0, arg1, 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::create_from_raw_value(0x2::bcs::peel_u128(v1), 0x2::bcs::peel_bool(v1)), 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::create_from_raw_value(0x2::bcs::peel_u128(v3), 0x2::bcs::peel_bool(v3)), 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64::create_from_raw_value(arg4), arg5, arg6);
    }

    fun create_new_market_internal<T0: drop>(arg0: &0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::pt::PTStruct<T0>, arg1: &mut 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::market_global::MarketFactoryConfig, arg2: 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::FixedPoint64WithSign, arg4: 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64::FixedPoint64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::pt::expiry<T0>(arg0);
        assert!(v0 > 0x2::clock::timestamp_ms(arg5), 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::error::market_pt_expired());
        assert!(0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::less_or_equal(0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::create_from_raw_value(0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64::get_raw_value(arg4), true), 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::math_fixed64_with_sign::ln(0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::create_from_rational(105, 100, true))), 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::error::market_ln_fee_rate_too_high());
        assert!(0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::greater_or_equal(arg3, 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::one()), 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::error::market_initial_anchor_too_low());
        assert!(!0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::is_zero(arg2), 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::error::market_scalar_root_is_zero());
        let v1 = calc_market_id<T0>(arg0, arg2, arg3, 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::create_from_raw_value(0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64::get_raw_value(arg4), true));
        assert!(!0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::market_global::contains(arg1, v1), 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::error::market_exists());
        0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::market::create<T0>(v0, arg2, arg3, arg4, arg6);
        0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::market_global::add(arg1, v1);
        let v2 = MarketCreatedEvent{
            marketId        : v1,
            factoryConfigId : 0x2::object::id<0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::market_global::MarketFactoryConfig>(arg1),
            ptId            : 0x2::object::id<0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::pt::PTStruct<T0>>(arg0),
            expiry          : v0,
            scalarRoot      : arg2,
            initialAnchor   : arg3,
            lnFeeRateRoot   : arg4,
        };
        0x2::event::emit<MarketCreatedEvent>(v2);
    }

    public fun create_new_market_with_raw_values<T0: drop>(arg0: &0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::pt::PTStruct<T0>, arg1: &mut 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::market_global::MarketFactoryConfig, arg2: u128, arg3: bool, arg4: u128, arg5: bool, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        create_new_market_internal<T0>(arg0, arg1, 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::create_from_raw_value(arg2, arg3), 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64_with_sign::create_from_raw_value(arg4, arg5), 0x568fa1b0dead1ebb029df6865a73de740e212c35007a6f3ef5afc24f969e7f3a::fixed_point64::create_from_raw_value(arg6), arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

