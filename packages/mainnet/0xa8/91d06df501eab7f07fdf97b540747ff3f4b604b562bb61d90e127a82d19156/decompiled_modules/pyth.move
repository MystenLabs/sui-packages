module 0xa891d06df501eab7f07fdf97b540747ff3f4b604b562bb61d90e127a82d19156::pyth {
    struct OracleAggregatorPythIntegration has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun borrow_id(arg0: &OracleAggregatorPythIntegration) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_mut_id(arg0: &mut OracleAggregatorPythIntegration, arg1: &0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::AuthorityCap<0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::PACKAGE, 0x65db0cc750b08565dd178c6b5e66069a6485536a6e5371d3157dc2194717d666::authority::ADMIN>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun create_pyth_integration_object_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        let v0 = OracleAggregatorPythIntegration{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<OracleAggregatorPythIntegration>(v0);
    }

    // decompiled from Move bytecode v6
}

