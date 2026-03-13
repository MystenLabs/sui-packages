module 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::sealed_stake_action {
    public fun execute_sealed_stake(arg0: &mut 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::Intent<0x2::sui::SUI>, arg1: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::config::ProtocolConfig, arg2: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::registry::KeeperRegistry, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::registry::is_paused(arg2), 283);
        assert!(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::registry::is_allowed(arg2, 0x2::tx_context::sender(arg7)), 284);
        assert!(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::action_block_type(0x1::vector::borrow<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::ActionBlock>(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::actions<0x2::sui::SUI>(arg0), 0)) == 1, 280);
        0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::sealed_intent::verify_sealed_data<0x2::sui::SUI>(arg0, &arg5);
        let (v0, v1, v2) = 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::sealed_intent::deserialize_sealed_data(arg5);
        let v3 = v2;
        let v4 = v1;
        assert!(0x1::vector::length<u8>(&v3) == 33, 281);
        let v5 = 0x2::bcs::new(v3);
        0x2::bcs::peel_u8(&mut v5);
        let v6 = 0x2::bcs::peel_address(&mut v5);
        assert!(v6 != @0x0, 282);
        let (v7, v8, v9) = 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::execute_sealed<0x2::sui::SUI>(arg0, arg1, v0, &v4, arg4, arg6, arg7);
        0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(0x3::sui_system::request_add_stake_non_entry(arg3, v7, v6, arg7), 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::owner<0x2::sui::SUI>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::config::treasury(arg1));
    }

    // decompiled from Move bytecode v6
}

