module 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator_set_authority_action {
    struct AggregatorAuthorityUpdated has copy, drop {
        aggregator_id: 0x2::object::ID,
        existing_authority: address,
        new_authority: address,
    }

    fun actuate(arg0: &mut 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::Aggregator, arg1: address) {
        let v0 = AggregatorAuthorityUpdated{
            aggregator_id      : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::id(arg0),
            existing_authority : 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::authority(arg0),
            new_authority      : arg1,
        };
        0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::set_authority(arg0, arg1);
        0x2::event::emit<AggregatorAuthorityUpdated>(v0);
    }

    public entry fun run(arg0: &mut 0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::Aggregator, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg2);
        actuate(arg0, arg1);
    }

    public fun validate(arg0: &0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::Aggregator, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x957633c1fd294857390f99dda23524eee7d8bb1671acd7e0c05aaeba38dc98f4::aggregator::has_authority(arg0, arg1), 9223372105574252545);
    }

    // decompiled from Move bytecode v6
}

