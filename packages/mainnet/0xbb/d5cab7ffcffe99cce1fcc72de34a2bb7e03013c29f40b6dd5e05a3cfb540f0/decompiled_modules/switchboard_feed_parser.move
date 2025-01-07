module 0xbbd5cab7ffcffe99cce1fcc72de34a2bb7e03013c29f40b6dd5e05a3cfb540f0::switchboard_feed_parser {
    struct AggregatorInfo has copy, drop {
        aggregator_addr: address,
        latest_result: u128,
        latest_result_scaling_factor: u8,
        latest_timestamp: u64,
        negative: bool,
    }

    public(friend) fun log_aggregator_info(arg0: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) : (u128, u8) {
        let (v0, v1) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::latest_value(arg0);
        let (v2, v3, v4) = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::unpack(v0);
        let v5 = AggregatorInfo{
            aggregator_addr              : 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::aggregator_address(arg0),
            latest_result                : v2,
            latest_result_scaling_factor : v3,
            latest_timestamp             : v1,
            negative                     : v4,
        };
        0x2::event::emit<AggregatorInfo>(v5);
        (v2, v3)
    }

    // decompiled from Move bytecode v6
}

