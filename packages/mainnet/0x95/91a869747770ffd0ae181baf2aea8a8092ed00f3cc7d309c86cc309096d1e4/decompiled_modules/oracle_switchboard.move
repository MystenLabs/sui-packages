module 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle_switchboard {
    public fun submit<T0, T1>(arg0: &mut 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle::PriceOracle<T0, T1>, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        assert!(0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle::switchboard_aggregator_id<T0, T1>(arg0) == 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(arg1), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::oracle_mismatch());
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg1);
        let v1 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0);
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(v1), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::errors::oracle_bad_source());
        0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle::submit<T0, T1>(arg0, 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle::source_switchboard(), 0x9591a869747770ffd0ae181baf2aea8a8092ed00f3cc7d309c86cc309096d1e4::oracle::normalize_human<T0, T1>(arg0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(v1), 18), 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::min_timestamp_ms(v0));
    }

    // decompiled from Move bytecode v7
}

