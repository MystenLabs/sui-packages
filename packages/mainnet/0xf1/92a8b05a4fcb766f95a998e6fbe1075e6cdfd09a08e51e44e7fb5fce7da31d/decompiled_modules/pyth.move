module 0xf192a8b05a4fcb766f95a998e6fbe1075e6cdfd09a08e51e44e7fb5fce7da31d::pyth {
    struct OracleAggregatorPythIntegration has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun borrow_id(arg0: &OracleAggregatorPythIntegration) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_mut_id(arg0: &mut OracleAggregatorPythIntegration, arg1: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::AuthorityCap<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::PACKAGE, 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::ADMIN>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun create_pyth_integration_object_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        let v0 = OracleAggregatorPythIntegration{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<OracleAggregatorPythIntegration>(v0);
    }

    // decompiled from Move bytecode v6
}

