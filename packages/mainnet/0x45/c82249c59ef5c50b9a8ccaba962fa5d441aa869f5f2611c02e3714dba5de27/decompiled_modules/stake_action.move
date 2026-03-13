module 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::stake_action {
    public fun execute_stake(arg0: &mut 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::Intent<0x2::sui::SUI>, arg1: &0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::config::ProtocolConfig, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow<0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::ActionBlock>(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::actions<0x2::sui::SUI>(arg0), 0);
        assert!(0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::action_block_type(v0) == 1, 210);
        let v1 = 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::action_block_params(v0);
        assert!(0x1::vector::length<u8>(&v1) == 33, 211);
        let v2 = 0x2::bcs::new(v1);
        0x2::bcs::peel_u8(&mut v2);
        let v3 = 0x2::bcs::peel_address(&mut v2);
        assert!(v3 != @0x0, 212);
        let (v4, v5, v6) = 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::execute_intent<0x2::sui::SUI>(arg0, arg1, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(0x3::sui_system::request_add_stake_non_entry(arg2, v4, v3, arg5), 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::intent::owner<0x2::sui::SUI>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::config::treasury(arg1));
    }

    // decompiled from Move bytecode v6
}

