module 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::oracle_switchboard {
    public fun submit<T0, T1>(arg0: &mut 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::oracle::PriceOracle<T0, T1>, arg1: &0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::config::LotusConfig, arg2: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg3: &0x2::clock::Clock) {
        assert!(0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::oracle::switchboard_aggregator_id<T0, T1>(arg0) == 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg2), 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::errors::oracle_mismatch());
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg2);
        let v1 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0);
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(v1), 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::errors::oracle_bad_source());
        0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::oracle::accept<T0, T1>(arg0, arg1, 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::oracle::source_switchboard(), 0xcfca314a98f7bd8f429adfefcfb4ad5adec336484b8f3c17bdc221f821a60d43::oracle::normalize_human<T0, T1>(arg0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(v1), 18), 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::min_timestamp_ms(v0), arg3);
    }

    // decompiled from Move bytecode v7
}

