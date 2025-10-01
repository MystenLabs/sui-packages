module 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::cranking_action {
    public fun claim(arg0: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::StakingContract, arg1: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_correct_version(arg0);
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::valid_staking_data(arg1, 0x2::tx_context::sender(arg3)), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EIncorrectStakingData());
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_last_claimed(arg1) > 0, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_ENeverStaked());
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::update_points(arg1, 0x2::clock::timestamp_ms(arg2));
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_data_updated(0x2::object::id<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData>(arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_points(arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_current_multiplier(arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_ephemeral_multiplier(arg1));
    }

    public fun increase_level(arg0: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::StakingContract, arg1: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_correct_version(arg0);
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::valid_staking_data(arg1, 0x2::tx_context::sender(arg3)), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EIncorrectStakingData());
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_current_level(arg1) < 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_MAX_LEVEL(), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EAlreadyAtMaximumLevel());
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_last_claimed(arg1) > 0, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_ENeverStaked());
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::update_points(arg1, 0x2::clock::timestamp_ms(arg2));
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::has_enough_points(arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_ENotEnoughPoints());
        let v0 = 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_current_level_mut(arg1);
        *v0 = *v0 + 1;
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_data_level_updated(0x2::object::id<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData>(arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_points(arg1), *v0);
    }

    // decompiled from Move bytecode v6
}

