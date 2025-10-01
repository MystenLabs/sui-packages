module 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::modify_class {
    public fun modify_class_no_data(arg0: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::admin_cap::AdminCap, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::StakingContract) {
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_correct_version(arg3);
        assert!(!0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_in_staking_contract(arg3, arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EAssetInStakingContract());
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::class_exists(arg3, arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EClassNotFound());
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::set_class_multiplier(arg3, arg1, arg2);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_class_updated(arg1, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_class_multiplier(arg3, arg1), false, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_class_lock_time(arg3, arg1));
    }

    public fun modify_class_with_data(arg0: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::admin_cap::AdminCap, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::StakingContract, arg4: &0x2::clock::Clock, arg5: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData) {
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_correct_version(arg3);
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_in_staking_contract(arg3, arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EAssetNotInStakingContract());
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::is_in_staking_data(arg5, arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EAssetNotInStakingData());
        assert!(0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::class_exists(arg3, arg1), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EClassNotFound());
        let v0 = 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_class_multiplier(arg3, arg1);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::set_class_multiplier(arg3, arg1, arg2);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::update_points(arg5, 0x2::clock::timestamp_ms(arg4));
        if (arg2 > v0) {
            0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::increase_current_multiplier(arg5, arg2 - v0);
        } else {
            0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::decrease_current_multiplier(arg5, v0 - arg2);
        };
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_data_updated(0x2::object::id<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData>(arg5), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_points(arg5), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_current_multiplier(arg5), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_ephemeral_multiplier(arg5));
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_class_updated(arg1, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_class_multiplier(arg3, arg1), true, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::get_class_lock_time(arg3, arg1));
    }

    // decompiled from Move bytecode v6
}

