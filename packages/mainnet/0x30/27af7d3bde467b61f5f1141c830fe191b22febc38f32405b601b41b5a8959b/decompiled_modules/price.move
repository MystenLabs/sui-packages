module 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::price {
    public fun get_price(arg0: &0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::price_feed::PriceFeed>(v0, arg1), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::price_feed::last_updated(v1), 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x3027af7d3bde467b61f5f1141c830fe191b22febc38f32405b601b41b5a8959b::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x5426f3642f8bb08fb9fe78d25f543730a30b9a248bcf1bd816c6dd5d650921f2::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

