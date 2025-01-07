module 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::oracles {
    fun check_price_staleness(arg0: u64, arg1: u64, arg2: u64) {
        assert!(0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::math::abs_diff_u64(arg0, arg1 * 1000) <= arg2, 1);
    }

    public fun get_price_from_oracle(arg0: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg1: u64, arg2: u64, arg3: u8) : (u256, u256, u64) {
        let (v0, v1) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::latest_value(arg0);
        check_price_staleness(arg1, v1, arg2);
        let (v2, v3) = sbd_to_price_info(v0, arg3);
        (v2, v3, v1)
    }

    public fun sbd_to_price_info(arg0: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal, arg1: u8) : (u256, u256) {
        let (v0, v1, v2) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::unpack(arg0);
        assert!(!v2, 0);
        ((v0 as u256), 0x5b05e2c12f617b33b64ea2b004d89cc18c46b270bc0c214ddd32654fa9a8c84c::math::pow(10, arg1 - v1))
    }

    // decompiled from Move bytecode v6
}

