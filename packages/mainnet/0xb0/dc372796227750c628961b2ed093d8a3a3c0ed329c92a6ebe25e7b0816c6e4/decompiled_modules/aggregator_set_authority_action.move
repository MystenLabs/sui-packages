module 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator_set_authority_action {
    struct AggregatorAuthorityUpdated has copy, drop {
        aggregator_id: 0x2::object::ID,
        existing_authority: address,
        new_authority: address,
    }

    fun actuate(arg0: &mut 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator::Aggregator, arg1: address) {
        let v0 = AggregatorAuthorityUpdated{
            aggregator_id      : 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator::id(arg0),
            existing_authority : 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator::authority(arg0),
            new_authority      : arg1,
        };
        0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator::set_authority(arg0, arg1);
        0x2::event::emit<AggregatorAuthorityUpdated>(v0);
    }

    public entry fun run(arg0: &mut 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator::Aggregator, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        validate(arg0, arg2);
        actuate(arg0, arg1);
    }

    public fun validate(arg0: &0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator::Aggregator, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator::version(arg0) == 1, 9223372122754318340);
        assert!(0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator::has_authority(arg0, arg1), 9223372127049154562);
    }

    // decompiled from Move bytecode v6
}

