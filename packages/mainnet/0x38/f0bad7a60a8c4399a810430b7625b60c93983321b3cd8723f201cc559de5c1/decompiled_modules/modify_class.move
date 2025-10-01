module 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::modify_class {
    public fun modify_class_no_data(arg0: &0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::admin_cap::AdminCap, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::StakingContract) {
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::is_correct_version(arg3);
        assert!(!0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::is_in_staking_contract(arg3, arg1), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EAssetInStakingContract());
        assert!(0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::class_exists(arg3, arg1), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EClassNotFound());
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::set_class_multiplier(arg3, arg1, arg2);
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::events::emit_staking_class_updated(arg1, 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::get_class_multiplier(arg3, arg1), false, 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::get_class_lock_time(arg3, arg1));
    }

    public fun modify_class_with_data(arg0: &0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::admin_cap::AdminCap, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::StakingContract, arg4: &0x2::clock::Clock, arg5: &mut 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::StakingData) {
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::is_correct_version(arg3);
        assert!(0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::is_in_staking_contract(arg3, arg1), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EAssetNotInStakingContract());
        assert!(0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::is_in_staking_data(arg5, arg1), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EAssetNotInStakingData());
        assert!(0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::class_exists(arg3, arg1), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EClassNotFound());
        let v0 = 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::get_class_multiplier(arg3, arg1);
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::set_class_multiplier(arg3, arg1, arg2);
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::update_points(arg5, 0x2::clock::timestamp_ms(arg4));
        if (arg2 > v0) {
            0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::increase_current_multiplier(arg5, arg2 - v0);
        } else {
            0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::decrease_current_multiplier(arg5, v0 - arg2);
        };
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::events::emit_staking_data_updated(0x2::object::id<0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::StakingData>(arg5), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::get_points(arg5), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::get_current_multiplier(arg5), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::get_ephemeral_multiplier(arg5));
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::events::emit_staking_class_updated(arg1, 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::get_class_multiplier(arg3, arg1), true, 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::get_class_lock_time(arg3, arg1));
    }

    // decompiled from Move bytecode v6
}

