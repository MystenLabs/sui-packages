module 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::price {
    public fun get_price(arg0: &0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::price_feed::PriceFeed>(v0, arg1), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::price_feed::last_updated(v1), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::oracle_stale_price_error());
        assert!(v2 > 0, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0xe2785270b2e6179e68204dd5901a43f9a0e1c566baf656cad705d45a419c4d3a::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

