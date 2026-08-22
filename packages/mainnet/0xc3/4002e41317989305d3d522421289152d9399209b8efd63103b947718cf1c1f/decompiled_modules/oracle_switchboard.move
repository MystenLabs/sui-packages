module 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::oracle_switchboard {
    public fun submit<T0, T1>(arg0: &mut 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::oracle::PriceOracle<T0, T1>, arg1: &0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::config::LotusConfig, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg3: &0x2::clock::Clock) {
        assert!(0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::oracle::switchboard_aggregator_id<T0, T1>(arg0) == 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg2), 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::oracle_mismatch());
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg2);
        let v1 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0);
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(v1), 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::errors::oracle_bad_source());
        0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::oracle::accept<T0, T1>(arg0, arg1, 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::oracle::source_switchboard(), 0xc34002e41317989305d3d522421289152d9399209b8efd63103b947718cf1c1f::oracle::normalize_human<T0, T1>(arg0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(v1), 18), 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::min_timestamp_ms(v0), arg3);
    }

    // decompiled from Move bytecode v7
}

