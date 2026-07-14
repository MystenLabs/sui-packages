module 0x7134d49c89e68aa851f7d6d7772c76a96d4adb62c4858bcabe64782398d01f4d::pyth_adaptor {
    fun assert_price_conf_within_range(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = 10000;
        assert!(((((arg1 * v0 * 100) as u128) / (arg0 as u128)) as u64) <= arg2 * v0 * 100 / 0x7134d49c89e68aa851f7d6d7772c76a96d4adb62c4858bcabe64782398d01f4d::pyth_registry::conf_tolerance_denominator(), 70297);
    }

    fun assert_price_not_stale(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::Price, arg1: &0x2::clock::Clock) {
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(arg0) >= 0x2::clock::timestamp_ms(arg1) / 1000 - 30, 70146);
    }

    public(friend) fun get_pyth_price(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x7134d49c89e68aa851f7d6d7772c76a96d4adb62c4858bcabe64782398d01f4d::pyth_registry::PythFeedData, arg3: &0x2::clock::Clock) : (u64, u64, u8, u64) {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price(arg0, arg1, arg3);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v0);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v1);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&v0);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v0);
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v4);
        assert!(v5 <= 255, 70145);
        assert_price_not_stale(&v0, arg3);
        assert_price_conf_within_range(v2, v3, 0x7134d49c89e68aa851f7d6d7772c76a96d4adb62c4858bcabe64782398d01f4d::pyth_registry::price_conf_tolerance(arg2));
        (v2, v3, (v5 as u8), 0x2::clock::timestamp_ms(arg3) / 1000)
    }

    // decompiled from Move bytecode v7
}

