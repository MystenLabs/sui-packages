module 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::value {
    public fun clock_now(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun get_price(arg0: &0xcd9847dcdef37af236b3c6e3fe953a886e53daff970697c4db4414c15723f9f3::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal {
        let v0 = 0xcd9847dcdef37af236b3c6e3fe953a886e53daff970697c4db4414c15723f9f3::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xcd9847dcdef37af236b3c6e3fe953a886e53daff970697c4db4414c15723f9f3::price_feed::PriceFeed>(v0, arg1), 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0xcd9847dcdef37af236b3c6e3fe953a886e53daff970697c4db4414c15723f9f3::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0xcd9847dcdef37af236b3c6e3fe953a886e53daff970697c4db4414c15723f9f3::price_feed::value(v1);
        assert!(clock_now(arg2) == 0xcd9847dcdef37af236b3c6e3fe953a886e53daff970697c4db4414c15723f9f3::price_feed::last_updated(v1), 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x9057498e80fc95e54542c676a01d3e286583bd3ad973656d8016b0990605e0b4::error::oracle_zero_price_error());
        0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::from_quotient(v2, 0x1::u64::pow(10, 0xcd9847dcdef37af236b3c6e3fe953a886e53daff970697c4db4414c15723f9f3::price_feed::decimals()))
    }

    public fun usd_value(arg0: 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal, arg1: 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal, arg2: u8) : 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::Decimal {
        0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::div(0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::mul(arg0, arg1), 0xaf25665ea4e881fc4a78ad666578c63f62fd357555b017712869d27fa406457d::float::from(0x1::u64::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

