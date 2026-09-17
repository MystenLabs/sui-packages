module 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::pyth_price {
    public(friend) fun read(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg1: &vector<u8>) : 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::Price {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(&v0);
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v1) == *arg1, 100);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_unsafe(arg0);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v2);
        assert!(!0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v3), 101);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v3);
        assert!(v4 > 0, 101);
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v2);
        let (v6, v7) = if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v5)) {
            (true, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v5))
        } else {
            (false, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v5))
        };
        0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::oracle::new(0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::scale_to_e18(v4, v6, v7), 0xc23a402549e5a825567c0eb741d2668ef1d499c67edae8ea43db5cf861290b1b::math::scale_to_e18(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&v2), v6, v7), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v2) * 1000)
    }

    // decompiled from Move bytecode v7
}

