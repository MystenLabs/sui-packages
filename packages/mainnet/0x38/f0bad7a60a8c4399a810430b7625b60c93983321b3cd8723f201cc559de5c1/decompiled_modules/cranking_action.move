module 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::cranking_action {
    public fun claim(arg0: &0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::StakingContract, arg1: &mut 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::StakingData, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::is_correct_version(arg0);
        assert!(0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::valid_staking_data(arg1, 0x2::tx_context::sender(arg3)), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EIncorrectStakingData());
        assert!(0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::get_last_claimed(arg1) > 0, 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_ENeverStaked());
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::update_points(arg1, 0x2::clock::timestamp_ms(arg2));
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::events::emit_staking_data_updated(0x2::object::id<0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::StakingData>(arg1), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::get_points(arg1), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::get_current_multiplier(arg1), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::get_ephemeral_multiplier(arg1));
    }

    public fun increase_level(arg0: &0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::StakingContract, arg1: &mut 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::StakingData, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_contract::is_correct_version(arg0);
        assert!(0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::valid_staking_data(arg1, 0x2::tx_context::sender(arg3)), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EIncorrectStakingData());
        assert!(0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::get_current_level(arg1) < 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_MAX_LEVEL(), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_EAlreadyAtMaximumLevel());
        assert!(0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::get_last_claimed(arg1) > 0, 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_ENeverStaked());
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::update_points(arg1, 0x2::clock::timestamp_ms(arg2));
        assert!(0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::has_enough_points(arg1), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::constant::get_ENotEnoughPoints());
        let v0 = 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::get_current_level_mut(arg1);
        *v0 = *v0 + 1;
        0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::events::emit_staking_data_level_updated(0x2::object::id<0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::StakingData>(arg1), 0x38f0bad7a60a8c4399a810430b7625b60c93983321b3cd8723f201cc559de5c1::staking_data::get_points(arg1), *v0);
    }

    // decompiled from Move bytecode v6
}

