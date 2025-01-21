module 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator_delete_action {
    struct AggregatorDeleted has copy, drop {
        aggregator_id: 0x2::object::ID,
    }

    fun actuate(arg0: 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator::Aggregator) {
        let v0 = AggregatorDeleted{aggregator_id: 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator::id(&arg0)};
        0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator::delete(arg0);
        0x2::event::emit<AggregatorDeleted>(v0);
    }

    public entry fun run(arg0: 0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator::Aggregator, arg1: &mut 0x2::tx_context::TxContext) {
        validate(&arg0, arg1);
        actuate(arg0);
    }

    public fun validate(arg0: &0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator::Aggregator, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator::version(arg0) == 1, 9223372114164383748);
        assert!(0xb0dc372796227750c628961b2ed093d8a3a3c0ed329c92a6ebe25e7b0816c6e4::aggregator::has_authority(arg0, arg1), 9223372118459219970);
    }

    // decompiled from Move bytecode v6
}

