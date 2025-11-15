module 0x2a99029ef4e0f3c2b6a0d2329958ae1fd08ffa27e68d7b6dd7dad8e3b909e87e::price_query {
    public fun get_price_u64<T0>(arg0: &0x4b259760c965a5e4a9a9c809f73dce11aef06a401984c3dd4dfcdfb2b890db7a::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x4b259760c965a5e4a9a9c809f73dce11aef06a401984c3dd4dfcdfb2b890db7a::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x4b259760c965a5e4a9a9c809f73dce11aef06a401984c3dd4dfcdfb2b890db7a::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x4b259760c965a5e4a9a9c809f73dce11aef06a401984c3dd4dfcdfb2b890db7a::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x4b259760c965a5e4a9a9c809f73dce11aef06a401984c3dd4dfcdfb2b890db7a::price_feed::last_updated(v2), 1);
        0x4b259760c965a5e4a9a9c809f73dce11aef06a401984c3dd4dfcdfb2b890db7a::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

