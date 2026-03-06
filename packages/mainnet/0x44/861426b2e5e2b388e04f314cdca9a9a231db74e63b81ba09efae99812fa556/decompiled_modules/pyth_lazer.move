module 0x44861426b2e5e2b388e04f314cdca9a9a231db74e63b81ba09efae99812fa556::pyth_lazer {
    struct OracleAggregatorPythLazerIntegration has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun borrow_id(arg0: &OracleAggregatorPythLazerIntegration) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_mut_id<T0>(arg0: &mut OracleAggregatorPythLazerIntegration, arg1: &0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::AuthorityCap<0xa8172ed2a6f14cd0ee55124326685713d6f765039e7c5339f7a0b57be06fddb5::authority::PACKAGE, T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun create_pyth_lazer_integration_object_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        let v0 = OracleAggregatorPythLazerIntegration{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<OracleAggregatorPythLazerIntegration>(v0);
    }

    // decompiled from Move bytecode v6
}

