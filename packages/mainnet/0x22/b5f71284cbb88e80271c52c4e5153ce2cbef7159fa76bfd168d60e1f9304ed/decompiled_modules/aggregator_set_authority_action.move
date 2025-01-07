module 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator_set_authority_action {
    struct AggregatorAuthorityUpdated has copy, drop {
        aggregator_id: 0x2::object::ID,
        existing_authority: address,
        new_authority: address,
    }

    fun actuate(arg0: &mut 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::Aggregator, arg1: address) {
        let v0 = AggregatorAuthorityUpdated{
            aggregator_id      : 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::id(arg0),
            existing_authority : 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::authority(arg0),
            new_authority      : arg1,
        };
        0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::set_authority(arg0, arg1);
        0x2::event::emit<AggregatorAuthorityUpdated>(v0);
    }

    public entry fun run(arg0: &mut 0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::Aggregator, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg2);
        actuate(arg0, arg1);
    }

    public fun validate(arg0: &0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::Aggregator, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::version(arg0) == 1, 9223372122754318340);
        assert!(0x22b5f71284cbb88e80271c52c4e5153ce2cbef7159fa76bfd168d60e1f9304ed::aggregator::has_authority(arg0, arg1), 9223372127049154562);
    }

    // decompiled from Move bytecode v6
}

