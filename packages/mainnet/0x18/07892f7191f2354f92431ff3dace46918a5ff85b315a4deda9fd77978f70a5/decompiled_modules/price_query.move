module 0x1807892f7191f2354f92431ff3dace46918a5ff85b315a4deda9fd77978f70a5::price_query {
    public fun get_price_u64<T0>(arg0: &0x4999c75c8e680bc1b56f5c1d6734dfaa88dbc9d799a1dc58c0000a6dbcfabd2b::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x4999c75c8e680bc1b56f5c1d6734dfaa88dbc9d799a1dc58c0000a6dbcfabd2b::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x4999c75c8e680bc1b56f5c1d6734dfaa88dbc9d799a1dc58c0000a6dbcfabd2b::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x4999c75c8e680bc1b56f5c1d6734dfaa88dbc9d799a1dc58c0000a6dbcfabd2b::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x4999c75c8e680bc1b56f5c1d6734dfaa88dbc9d799a1dc58c0000a6dbcfabd2b::price_feed::last_updated(v2), 1);
        0x4999c75c8e680bc1b56f5c1d6734dfaa88dbc9d799a1dc58c0000a6dbcfabd2b::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

