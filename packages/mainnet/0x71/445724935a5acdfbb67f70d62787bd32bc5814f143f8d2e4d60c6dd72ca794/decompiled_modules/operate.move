module 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::operate {
    public entry fun set_deposit_fee(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg2: u64) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg1);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::config::set_deposit_fee(0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::get_config_mut(arg1), arg2);
    }

    public entry fun set_reward_fee(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg2: u64) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg1);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::config::set_reward_fee(0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::get_config_mut(arg1), arg2);
    }

    public entry fun set_service_fee(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg2: u64) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg1);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::config::set_service_fee(0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::get_config_mut(arg1), arg2);
    }

    public entry fun set_validator_count(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg2: u64) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg1);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::config::set_validator_count(0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::get_config_mut(arg1), arg2);
    }

    public entry fun set_validator_reward_fee(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg2: u64) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg1);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::config::set_validator_reward_fee(0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::get_config_mut(arg1), arg2);
    }

    public entry fun set_walrus_epoch_start(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg2: u32, arg3: u64, arg4: u64) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg1);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::config::set_walrus_epoch_start(0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::get_config_mut(arg1), arg2, arg3, arg4);
    }

    public entry fun set_withdraw_time_limit(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg2: u64) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg1);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::config::set_withdraw_time_limit(0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::get_config_mut(arg1), arg2);
    }

    public entry fun claim_collect_protocol_fee(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg1);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::claim_collect_protocol_fee(arg1, arg2, arg3);
    }

    public entry fun claim_collect_rewards_fee(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg3);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::claim_collect_rewards_fee(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun migrate(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::migrate(arg1);
    }

    public entry fun request_collect_rewards_fee(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun set_active_validators(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg2: vector<0x2::object::ID>) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg1);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::set_active_validators(arg1, arg2);
    }

    public entry fun sort_validators(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg2: vector<0x2::object::ID>) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg1);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::sort_validators(arg1, arg2);
    }

    public entry fun toggle_claim(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg2: bool) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg1);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::toggle_claim(arg1, arg2);
    }

    public entry fun toggle_stake(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg2: bool) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg1);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::toggle_stake(arg1, arg2);
    }

    public entry fun toggle_unstake(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg2: bool) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg1);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::toggle_unstake(arg1, arg2);
    }

    public entry fun update_validator_rewards(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg1);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::update_validator_rewards(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun validator_offline(arg0: &0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::manage::OperatorCap, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg3: &mut 0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::Staking, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::assert_version(arg3);
        0x71445724935a5acdfbb67f70d62787bd32bc5814f143f8d2e4d60c6dd72ca794::walstaking::do_validator_offline(arg3, arg1, arg2, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

