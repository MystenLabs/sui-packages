module 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::price {
    public fun get_price(arg0: &0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::price_feed::PriceFeed>(v0, arg1), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::price_feed::last_updated(v1), 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::oracle_stale_price_error());
        assert!(v2 > 0, 0xd14a0bbd2a61e682c889829fae2bdbcd189bd097285a561e91abae64e25db4e2::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

