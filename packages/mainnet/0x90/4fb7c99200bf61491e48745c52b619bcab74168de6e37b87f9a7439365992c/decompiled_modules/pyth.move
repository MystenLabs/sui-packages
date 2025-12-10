module 0x904fb7c99200bf61491e48745c52b619bcab74168de6e37b87f9a7439365992c::pyth {
    struct OracleAggregatorPythIntegration has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun borrow_id(arg0: &OracleAggregatorPythIntegration) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_mut_id(arg0: &mut OracleAggregatorPythIntegration, arg1: &0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::AuthorityCap<0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::PACKAGE, 0x855b6d7d8a712a5ab48bb7a2d1c20c85cefdd51af68dc3691c59bfccb372e49::authority::ADMIN>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun create_pyth_integration_object_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        let v0 = OracleAggregatorPythIntegration{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<OracleAggregatorPythIntegration>(v0);
    }

    // decompiled from Move bytecode v6
}

