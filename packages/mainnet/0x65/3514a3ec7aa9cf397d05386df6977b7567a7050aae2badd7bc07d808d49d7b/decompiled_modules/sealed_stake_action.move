module 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::sealed_stake_action {
    public fun execute_sealed_stake(arg0: &mut 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::Intent<0x2::sui::SUI>, arg1: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::ProtocolConfig, arg2: &0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry::KeeperRegistry, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry::is_paused(arg2), 283);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::registry::is_allowed(arg2, 0x2::tx_context::sender(arg7)), 284);
        assert!(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::action_block_type(0x1::vector::borrow<0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::ActionBlock>(0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::actions<0x2::sui::SUI>(arg0), 0)) == 1, 280);
        0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::sealed_intent::verify_sealed_data<0x2::sui::SUI>(arg0, &arg5);
        let (v0, v1, v2) = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::sealed_intent::deserialize_sealed_data(arg5);
        let v3 = v2;
        let v4 = v1;
        assert!(0x1::vector::length<u8>(&v3) == 33, 281);
        let v5 = 0x2::bcs::new(v3);
        0x2::bcs::peel_u8(&mut v5);
        let v6 = 0x2::bcs::peel_address(&mut v5);
        assert!(v6 != @0x0, 282);
        let (v7, v8, v9) = 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::execute_sealed<0x2::sui::SUI>(arg0, arg1, v0, &v4, arg4, arg6, arg7);
        0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(0x3::sui_system::request_add_stake_non_entry(arg3, v7, v6, arg7), 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::intent::owner<0x2::sui::SUI>(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, 0x653514a3ec7aa9cf397d05386df6977b7567a7050aae2badd7bc07d808d49d7b::config::treasury(arg1));
    }

    // decompiled from Move bytecode v6
}

