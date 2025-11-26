module 0xfda88734cc3c4df7075267250e38479486257f6845994d7b30cb9379dd30c5ef::price_query {
    public fun get_price_u64<T0>(arg0: &0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::price_feed::last_updated(v2), 1);
        0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

