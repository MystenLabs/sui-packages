module 0x4efb528e0c2cb13cc81176d9c9e8b2e64b377a602d7648527d9170ec453df792::adaptor_switchboard {
    fun decimal_to_wad(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::Decimal) : u128 {
        assert!(!0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::neg(arg0), 1);
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::decimal::value(arg0);
        assert!(v0 > 0, 2);
        v0
    }

    public fun update_price<T0>(arg0: &mut 0x4efb528e0c2cb13cc81176d9c9e8b2e64b377a602d7648527d9170ec453df792::pyth_oracle::Oracle, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::current_result(arg1);
        0x4efb528e0c2cb13cc81176d9c9e8b2e64b377a602d7648527d9170ec453df792::pyth_oracle::update_price<0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator>(arg0, 0x1::type_name::with_defining_ids<T0>(), 2, decimal_to_wad(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::result(v0)), 0, 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::timestamp_ms(v0), arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

