module 0xb1ffb3a87ad3cd8e05767e48447cb946d82714790c889f2b818feec6d87a7927::dev {
    struct OracleAggregatorDevIntegration has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun borrow_id(arg0: &OracleAggregatorDevIntegration) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_mut_id(arg0: &mut OracleAggregatorDevIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun create_dev_integration_object_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        let v0 = OracleAggregatorDevIntegration{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<OracleAggregatorDevIntegration>(v0);
    }

    // decompiled from Move bytecode v6
}

