module 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::market_factory {
    struct MarketCreatedEvent has copy, drop {
        marketId: 0x1::string::String,
        factoryConfigId: 0x2::object::ID,
        ptId: 0x2::object::ID,
        expiry: u64,
        scalarRoot: 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::FixedPoint64WithSign,
        initialAnchor: 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::FixedPoint64WithSign,
        lnFeeRateRoot: 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64::FixedPoint64,
    }

    fun calc_market_id<T0>(arg0: &0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::pt::PTStruct<T0>, arg1: 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::FixedPoint64WithSign, arg2: 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::FixedPoint64WithSign, arg3: 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::FixedPoint64WithSign) : 0x1::string::String {
        let v0 = 0x2::object::id<0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::pt::PTStruct<T0>>(arg0);
        let v1 = 0x2::object::id_to_bytes(&v0);
        let v2 = 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::get_raw_value(arg1);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u128>(&v2));
        let v3 = 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::get_raw_value(arg2);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u128>(&v3));
        let v4 = 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::get_raw_value(arg3);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u128>(&v4));
        0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::utils::vector_to_hex_string(0x1::hash::sha2_256(v1))
    }

    public fun create_new_market<T0: drop>(arg0: &0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::pt::PTStruct<0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::sy::SYCoin<T0>>, arg1: &mut 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::market_global::MarketFactoryConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg2);
        let v1 = &mut v0;
        let v2 = 0x2::bcs::new(arg3);
        let v3 = &mut v2;
        let v4 = 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::create_from_raw_value(0x2::bcs::peel_u128(v1), 0x2::bcs::peel_bool(v1));
        let v5 = 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::create_from_raw_value(0x2::bcs::peel_u128(v3), 0x2::bcs::peel_bool(v3));
        let v6 = 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64::create_from_raw_value(arg4);
        let v7 = 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::pt::expiry<0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::sy::SYCoin<T0>>(arg0);
        assert!(v7 > 0x2::clock::timestamp_ms(arg5), 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::error::market_pt_expired());
        assert!(0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::less_or_equal(0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::create_from_raw_value(0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64::get_raw_value(v6), true), 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::math_fixed64_with_sign::ln(0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::create_from_rational(105, 100, true))), 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::error::market_ln_fee_rate_too_high());
        assert!(0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::greater_or_equal(v5, 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::one()), 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::error::market_initial_anchor_too_low());
        assert!(!0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::is_zero(v4), 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::error::market_scalar_root_is_zero());
        let v8 = calc_market_id<0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::sy::SYCoin<T0>>(arg0, v4, v5, 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64_with_sign::create_from_raw_value(0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64::get_raw_value(v6), true));
        assert!(!0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::market_global::contains(arg1, v8), 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::error::market_exists());
        0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::market::create<T0>(v7, v4, v5, v6, arg6);
        0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::market_global::add(arg1, v8);
        let v9 = MarketCreatedEvent{
            marketId        : v8,
            factoryConfigId : 0x2::object::id<0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::market_global::MarketFactoryConfig>(arg1),
            ptId            : 0x2::object::id<0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::pt::PTStruct<0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::sy::SYCoin<T0>>>(arg0),
            expiry          : v7,
            scalarRoot      : v4,
            initialAnchor   : v5,
            lnFeeRateRoot   : v6,
        };
        0x2::event::emit<MarketCreatedEvent>(v9);
    }

    // decompiled from Move bytecode v6
}

