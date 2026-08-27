module 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle_pyth_pro {
    public fun submit<T0, T1>(arg0: &mut 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle::PriceOracle<T0, T1>, arg1: &0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::config::LotusConfig, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg2);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_feed(&v0);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price_identifier(v1);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price(v1);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v3);
        assert!(!0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v4), 0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::errors::oracle_bad_source());
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v3);
        let v6 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v5);
        let v7 = if (v6) {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v5)
        } else {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v5)
        };
        0x145a2a1774cf0815d5b8c98bff403ea447ab13dae095b8f62545363e1fc12a5b::oracle_pyth::accept_attested<T0, T1>(arg0, arg1, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v2), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v4), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&v3), v7, v6, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v3), arg3);
    }

    // decompiled from Move bytecode v7
}

