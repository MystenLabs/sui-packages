module 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator_set_authority_action {
    struct AggregatorAuthorityUpdated has copy, drop {
        aggregator_id: 0x2::object::ID,
        existing_authority: address,
        new_authority: address,
    }

    fun actuate(arg0: &mut 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::Aggregator, arg1: address) {
        let v0 = AggregatorAuthorityUpdated{
            aggregator_id      : 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::id(arg0),
            existing_authority : 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::authority(arg0),
            new_authority      : arg1,
        };
        0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::set_authority(arg0, arg1);
        0x2::event::emit<AggregatorAuthorityUpdated>(v0);
    }

    public entry fun run(arg0: &mut 0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::Aggregator, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg2);
        actuate(arg0, arg1);
    }

    public fun validate(arg0: &0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::Aggregator, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xa4adb516d7c1a1e45ceaf54835c1f5a3ba79cd604fb95fd179914d87f7812321::aggregator::has_authority(arg0, arg1), 9223372105574252545);
    }

    // decompiled from Move bytecode v6
}

