module 0xf6c84fddbeaf59356ab53d1bc4b96f6a0547883ea0c5f25fc686ce04c8278d34::stork {
    struct OracleAggregatorStorkIntegration has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun borrow_id(arg0: &OracleAggregatorStorkIntegration) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_mut_id<T0>(arg0: &mut OracleAggregatorStorkIntegration, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun create_stork_integration_object_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        let v0 = OracleAggregatorStorkIntegration{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<OracleAggregatorStorkIntegration>(v0);
    }

    // decompiled from Move bytecode v6
}

