module 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::sealed_intent {
    public(friend) fun deserialize_sealed_data(arg0: vector<u8>) : (u64, 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::constraints::Constraints, vector<u8>) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_u64(&mut v0), 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::constraints::new_constraints(0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0)), 0x2::bcs::peel_vec_u8(&mut v0))
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::registry::KeeperRegistry, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 250);
        assert!(!0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::registry::is_paused(arg1), 252);
        assert!(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::registry::is_allowed(arg1, 0x2::tx_context::sender(arg2)), 251);
    }

    public(friend) fun verify_sealed_data<T0>(arg0: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::Intent<T0>, arg1: &vector<u8>) {
        assert!(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::is_sealed<T0>(arg0), 253);
        assert!(0x2::hash::blake2b256(arg1) == 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::action_block_params(0x1::vector::borrow<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::ActionBlock>(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::actions<T0>(arg0), 0)), 254);
    }

    // decompiled from Move bytecode v6
}

