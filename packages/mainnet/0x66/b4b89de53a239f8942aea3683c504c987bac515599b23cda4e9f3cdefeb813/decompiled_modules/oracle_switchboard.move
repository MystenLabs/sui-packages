module 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::oracle_switchboard {
    public fun submit<T0, T1>(arg0: &mut 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::oracle::PriceOracle<T0, T1>, arg1: &0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::config::LotusConfig, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg3: &0x2::clock::Clock) {
        assert!(0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::oracle::switchboard_aggregator_id<T0, T1>(arg0) == 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg2), 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::errors::oracle_mismatch());
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg2);
        let v1 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0);
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(v1), 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::errors::oracle_bad_source());
        0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::oracle::accept<T0, T1>(arg0, arg1, 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::oracle::source_switchboard(), 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::oracle::normalize_human<T0, T1>(arg0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(v1), 18), 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::min_timestamp_ms(v0), arg3);
    }

    // decompiled from Move bytecode v7
}

