module 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator_delete_action {
    struct AggregatorDeleted has copy, drop {
        aggregator_id: 0x2::object::ID,
    }

    fun actuate(arg0: 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator) {
        let v0 = AggregatorDeleted{aggregator_id: 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::id(&arg0)};
        0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::delete(arg0);
        0x2::event::emit<AggregatorDeleted>(v0);
    }

    public entry fun run(arg0: 0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: &mut 0x2::tx_context::TxContext) {
        validate(&arg0, arg1);
        actuate(arg0);
    }

    public fun validate(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::version(arg0) == 1, 9223372114164383748);
        assert!(0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::has_authority(arg0, arg1), 9223372118459219970);
    }

    // decompiled from Move bytecode v6
}

