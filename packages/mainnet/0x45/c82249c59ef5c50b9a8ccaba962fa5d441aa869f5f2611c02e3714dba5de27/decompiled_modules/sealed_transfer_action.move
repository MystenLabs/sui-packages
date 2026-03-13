module 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::sealed_transfer_action {
    public fun execute_sealed_transfer<T0>(arg0: &mut 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::Intent<T0>, arg1: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::config::ProtocolConfig, arg2: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::registry::KeeperRegistry, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::registry::is_paused(arg2), 273);
        assert!(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::registry::is_allowed(arg2, 0x2::tx_context::sender(arg6)), 274);
        assert!(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::action_block_type(0x1::vector::borrow<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::ActionBlock>(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::actions<T0>(arg0), 0)) == 2, 270);
        0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::sealed_intent::verify_sealed_data<T0>(arg0, &arg4);
        let (v0, v1, v2) = 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::sealed_intent::deserialize_sealed_data(arg4);
        let v3 = v2;
        let v4 = v1;
        assert!(0x1::vector::length<u8>(&v3) == 33, 271);
        let v5 = 0x2::bcs::new(v3);
        0x2::bcs::peel_u8(&mut v5);
        let v6 = 0x2::bcs::peel_address(&mut v5);
        assert!(v6 != @0x0, 272);
        let (v7, v8, v9) = 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::execute_sealed<T0>(arg0, arg1, v0, &v4, arg3, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::config::treasury(arg1));
    }

    // decompiled from Move bytecode v6
}

