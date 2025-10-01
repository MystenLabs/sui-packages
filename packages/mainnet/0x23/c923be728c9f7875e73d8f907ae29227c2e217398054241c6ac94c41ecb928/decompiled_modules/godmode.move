module 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::godmode {
    public fun add_ephemeral_multiplier(arg0: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::admin_cap::AdminCap, arg1: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::StakingContract, arg2: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData, arg3: &0x2::clock::Clock, arg4: u64, arg5: u64) {
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_correct_version(arg1);
        assert!(arg4 >= 1, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EInvalidMultiplier());
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg5 > v0, 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::constant::get_EInvalidExpiryTime());
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::update_points(arg2, v0);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::add_ephemeral_multiplier_to_staking_data(arg2, arg4, arg5, false);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_data_updated(0x2::object::id<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData>(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_points(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_current_multiplier(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_ephemeral_multiplier(arg2));
    }

    public fun add_experience(arg0: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::admin_cap::AdminCap, arg1: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::StakingContract, arg2: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData, arg3: &0x2::clock::Clock, arg4: u64) {
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_correct_version(arg1);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::update_points(arg2, 0x2::clock::timestamp_ms(arg3));
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::increase_points(arg2, arg4);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_data_updated(0x2::object::id<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData>(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_points(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_current_multiplier(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_ephemeral_multiplier(arg2));
    }

    public fun add_multiplier(arg0: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::admin_cap::AdminCap, arg1: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::StakingContract, arg2: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData, arg3: &0x2::clock::Clock, arg4: u64) {
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_correct_version(arg1);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::update_points(arg2, 0x2::clock::timestamp_ms(arg3));
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::increase_current_multiplier(arg2, arg4);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_data_updated(0x2::object::id<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData>(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_points(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_current_multiplier(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_ephemeral_multiplier(arg2));
    }

    public fun remove_ephemeral_multiplier(arg0: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::admin_cap::AdminCap, arg1: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::StakingContract, arg2: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData, arg3: &0x2::clock::Clock, arg4: 0x1::option::Option<u64>) {
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_correct_version(arg1);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::update_points(arg2, 0x2::clock::timestamp_ms(arg3));
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::remove_admin_ephemeral_multiplier(arg2, arg4);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_data_updated(0x2::object::id<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData>(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_points(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_current_multiplier(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_ephemeral_multiplier(arg2));
    }

    public fun remove_experience(arg0: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::admin_cap::AdminCap, arg1: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::StakingContract, arg2: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData, arg3: &0x2::clock::Clock, arg4: u64) {
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_correct_version(arg1);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::update_points(arg2, 0x2::clock::timestamp_ms(arg3));
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::decrease_points(arg2, arg4);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_data_updated(0x2::object::id<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData>(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_points(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_current_multiplier(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_ephemeral_multiplier(arg2));
    }

    public fun remove_multiplier(arg0: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::admin_cap::AdminCap, arg1: &0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::StakingContract, arg2: &mut 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData, arg3: &0x2::clock::Clock, arg4: u64) {
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_contract::is_correct_version(arg1);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::update_points(arg2, 0x2::clock::timestamp_ms(arg3));
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::decrease_current_multiplier(arg2, arg4);
        0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::events::emit_staking_data_updated(0x2::object::id<0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::StakingData>(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_points(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_current_multiplier(arg2), 0x23c923be728c9f7875e73d8f907ae29227c2e217398054241c6ac94c41ecb928::staking_data::get_ephemeral_multiplier(arg2));
    }

    // decompiled from Move bytecode v6
}

