module 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::create_class {
    public fun create_class_no_data(arg0: &0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::admin_cap::AdminCap, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::StakingContract, arg4: &0x2::clock::Clock) {
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::is_correct_version(arg3);
        assert!(arg2 > 1, 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EInvalidMultiplier());
        assert!(!0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::is_in_staking_contract(arg3, arg1), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EAssetInStakingContract());
        let v0 = 0x2::clock::timestamp_ms(arg4);
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::insert_class(arg3, arg1, arg2, v0);
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::events::emit_staking_class_created(arg1, arg2, false, v0);
    }

    // decompiled from Move bytecode v6
}

