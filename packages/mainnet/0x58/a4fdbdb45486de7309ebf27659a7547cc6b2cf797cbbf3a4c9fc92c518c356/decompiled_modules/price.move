module 0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::price {
    public fun get_price(arg0: &0xbece74970dc5b30686a3297b1c3ff1c8fb66c49d1b5a03ab9ce5614a42737f0a::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xbece74970dc5b30686a3297b1c3ff1c8fb66c49d1b5a03ab9ce5614a42737f0a::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xbece74970dc5b30686a3297b1c3ff1c8fb66c49d1b5a03ab9ce5614a42737f0a::price_feed::PriceFeed>(v0, arg1), 0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0xbece74970dc5b30686a3297b1c3ff1c8fb66c49d1b5a03ab9ce5614a42737f0a::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0xbece74970dc5b30686a3297b1c3ff1c8fb66c49d1b5a03ab9ce5614a42737f0a::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0xbece74970dc5b30686a3297b1c3ff1c8fb66c49d1b5a03ab9ce5614a42737f0a::price_feed::last_updated(v1), 0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x58a4fdbdb45486de7309ebf27659a7547cc6b2cf797cbbf3a4c9fc92c518c356::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0xbece74970dc5b30686a3297b1c3ff1c8fb66c49d1b5a03ab9ce5614a42737f0a::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

