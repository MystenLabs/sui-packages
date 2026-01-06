module 0x46f9b906c50dda5bfd2a7d207a620496eeb88b73904f7c0031ae3f87c59e2507::stork {
    struct OracleAggregatorStorkIntegration has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun borrow_id(arg0: &OracleAggregatorStorkIntegration) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_mut_id<T0>(arg0: &mut OracleAggregatorStorkIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun create_stork_integration_object_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        let v0 = OracleAggregatorStorkIntegration{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<OracleAggregatorStorkIntegration>(v0);
    }

    // decompiled from Move bytecode v6
}

