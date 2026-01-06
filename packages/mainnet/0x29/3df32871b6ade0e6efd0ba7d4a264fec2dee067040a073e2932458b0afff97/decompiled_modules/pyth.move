module 0x293df32871b6ade0e6efd0ba7d4a264fec2dee067040a073e2932458b0afff97::pyth {
    struct OracleAggregatorPythIntegration has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun borrow_id(arg0: &OracleAggregatorPythIntegration) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_mut_id(arg0: &mut OracleAggregatorPythIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, 0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::ADMIN>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun create_pyth_integration_object_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        let v0 = OracleAggregatorPythIntegration{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<OracleAggregatorPythIntegration>(v0);
    }

    // decompiled from Move bytecode v6
}

