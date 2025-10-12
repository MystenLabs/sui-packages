module 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::value {
    public fun clock_now(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun get_price(arg0: &0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal {
        let v0 = 0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::price_feed::PriceFeed>(v0, arg1), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::price_feed::value(v1);
        assert!(clock_now(arg2) == 0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::price_feed::last_updated(v1), 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::oracle_stale_price_error());
        assert!(v2 > 0, 0xc10127a01550b0ac02451499129c2f2810624b67b46264167eac45933ca2452d::error::oracle_zero_price_error());
        0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from_quotient(v2, 0x1::u64::pow(10, 0x64442484ac47ad2547a37432b8bb393b90f5db7e167a20f649f90386a7e23e80::price_feed::decimals()))
    }

    public fun usd_value(arg0: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, arg1: 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal, arg2: u8) : 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::Decimal {
        0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::div(0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::mul(arg0, arg1), 0x7f885241ae708ff7407c1eba20d6fabaf08c7ce817b8302490aff997635d722::float::from(0x1::u64::pow(10, arg2)))
    }

    // decompiled from Move bytecode v6
}

