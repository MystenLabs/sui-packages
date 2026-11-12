module 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::adaptor_switchboard {
    public fun get_aggregator_id(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) : address {
        abort 0
    }

    public fun get_identifier_to_vector(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) : vector<u8> {
        abort 0
    }

    public fun get_price_native(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) : (u128, u8, u64) {
        abort 0
    }

    public fun get_price_to_target_decimal(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: u8) : (u256, u64) {
        abort 0
    }

    // decompiled from Move bytecode v7
}

