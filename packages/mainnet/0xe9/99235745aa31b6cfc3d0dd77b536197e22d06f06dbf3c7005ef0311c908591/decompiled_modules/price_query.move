module 0xe999235745aa31b6cfc3d0dd77b536197e22d06f06dbf3c7005ef0311c908591::price_query {
    public fun get_price_u64<T0>(arg0: &0x3edad8ecca3dab286fe6707ab2dd3896ceb0a92efa60bd61693cc8803c6b20b7::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x3edad8ecca3dab286fe6707ab2dd3896ceb0a92efa60bd61693cc8803c6b20b7::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x3edad8ecca3dab286fe6707ab2dd3896ceb0a92efa60bd61693cc8803c6b20b7::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x3edad8ecca3dab286fe6707ab2dd3896ceb0a92efa60bd61693cc8803c6b20b7::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x3edad8ecca3dab286fe6707ab2dd3896ceb0a92efa60bd61693cc8803c6b20b7::price_feed::last_updated(v2), 1);
        0x3edad8ecca3dab286fe6707ab2dd3896ceb0a92efa60bd61693cc8803c6b20b7::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

