module 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::cycle {
    public(friend) fun add_coins_to_next(arg0: u256, arg1: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha) {
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::increment_global_value(arg1, global_next_reward_coins(), arg0);
    }

    public(friend) fun add_tokens_to_next(arg0: u256, arg1: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha) {
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::increment_global_value(arg1, global_next_reward_tokens(), arg0);
    }

    fun calculate_pending_reward_coins(arg0: address, arg1: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha) : u256 {
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg1, global_previous_staked_tokens());
        if (v0 == 0) {
            0
        } else if (0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_local_value(arg1, arg0, local_claim_timestamp()) < 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg1, global_previous_timestamp())) {
            0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg1, global_previous_reward_coins()) * 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_local_value(arg1, arg0, local_staked_tokens()) / v0
        } else {
            0
        }
    }

    fun calculate_pending_reward_tokens(arg0: address, arg1: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha) : u256 {
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg1, global_previous_staked_tokens());
        if (v0 == 0) {
            0
        } else if (0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_local_value(arg1, arg0, local_claim_timestamp()) < 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg1, global_previous_timestamp())) {
            0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg1, global_previous_reward_tokens()) * 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_local_value(arg1, arg0, local_staked_tokens()) / v0
        } else {
            0
        }
    }

    entry fun claim(arg0: address, arg1: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg3), 13906834711214292991);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg1);
        let v0 = calculate_pending_reward_coins(arg0, arg1);
        let v1 = calculate_pending_reward_tokens(arg0, arg1);
        assert!(v0 > 0, 13906834736984096767);
        assert!(v1 > 0, 13906834741279064063);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_local_value(arg1, arg0, local_claim_timestamp(), 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_timestamp(arg2));
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::decrement_global_value(arg1, global_previous_unclaimed_coins(), v0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::decrement_global_value(arg1, global_previous_unclaimed_tokens(), v1);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::vault::send_coins_to_account(arg1, arg0, v0, arg3);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::mint_tokens(arg0, v1, arg1, arg3);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::event::cycle_claimed(arg0, v0, v1);
    }

    fun global_next_reward_coins() : 0x1::string::String {
        0x1::string::utf8(b"cycle_next_reward_coins")
    }

    fun global_next_reward_tokens() : 0x1::string::String {
        0x1::string::utf8(b"cycle_next_reward_tokens")
    }

    fun global_next_staked_tokens() : 0x1::string::String {
        0x1::string::utf8(b"cycle_next_staked_tokens")
    }

    fun global_previous_reward_coins() : 0x1::string::String {
        0x1::string::utf8(b"cycle_previous_reward_coins")
    }

    fun global_previous_reward_tokens() : 0x1::string::String {
        0x1::string::utf8(b"cycle_previous_reward_tokens")
    }

    fun global_previous_staked_tokens() : 0x1::string::String {
        0x1::string::utf8(b"cycle_previous_staked_tokens")
    }

    fun global_previous_timestamp() : 0x1::string::String {
        0x1::string::utf8(b"cycle_previous_timestamp")
    }

    fun global_previous_unclaimed_coins() : 0x1::string::String {
        0x1::string::utf8(b"cycle_previous_unclaimed_coins")
    }

    fun global_previous_unclaimed_tokens() : 0x1::string::String {
        0x1::string::utf8(b"cycle_previous_unclaimed_tokens")
    }

    fun local_claim_timestamp() : 0x1::string::String {
        0x1::string::utf8(b"cycle_claim_timestamp")
    }

    fun local_staked_tokens() : 0x1::string::String {
        0x1::string::utf8(b"cycle_staked_tokens")
    }

    entry fun release(arg0: address, arg1: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg3), 13906834517940764671);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg1);
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg1, global_next_staked_tokens());
        assert!(v0 > 0, 13906834539415601151);
        let v1 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg1, global_next_reward_coins());
        let v2 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg1, global_previous_unclaimed_coins());
        let v3 = (v1 + v2) * 100 / 1000;
        let v4 = v1 + v2 - v3;
        assert!(v4 > 0, 13906834569480372223);
        let v5 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg1, global_next_reward_tokens());
        let v6 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg1, global_previous_unclaimed_tokens());
        let v7 = (v5 + v6) * 100 / 1000;
        let v8 = v5 + v6 - v7;
        assert!(v8 > 0, 13906834599545143295);
        assert!(0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::get_global_value(arg1, global_previous_timestamp()) + 86400000 < 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_timestamp(arg2), 13906834621019979775);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_global_value(arg1, global_previous_staked_tokens(), v0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_global_value(arg1, global_previous_reward_coins(), v4);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_global_value(arg1, global_previous_unclaimed_coins(), v4);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_global_value(arg1, global_previous_reward_tokens(), v8);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_global_value(arg1, global_previous_unclaimed_tokens(), v8);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_global_value(arg1, global_previous_timestamp(), 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_timestamp(arg2) + 1);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_global_value(arg1, global_next_reward_coins(), v3);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_global_value(arg1, global_next_reward_tokens(), v7);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::event::cycle_released(arg0, v4, v8);
    }

    entry fun stake(arg0: address, arg1: 0x2::coin::Coin<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>, arg2: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg4), 13906834268832661503);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg2);
        let v0 = 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u256(0x2::balance::value<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>(0x2::coin::balance<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>(&arg1)));
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::vault::add_tokens_to_balance(arg2, arg1);
        assert!(v0 >= 1000000000, 13906834303192399871);
        assert!(v0 <= 1000000000000000, 13906834307487367167);
        let v1 = calculate_pending_reward_coins(arg0, arg2);
        let v2 = calculate_pending_reward_tokens(arg0, arg2);
        assert!(v1 == 0, 13906834328962203647);
        assert!(v2 == 0, 13906834333257170943);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::increment_local_value(arg2, arg0, local_staked_tokens(), v0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_local_value(arg2, arg0, local_claim_timestamp(), 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_timestamp(arg3));
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::increment_global_value(arg2, global_next_staked_tokens(), v0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::event::cycle_staked(arg0, v0);
    }

    entry fun unstake(arg0: address, arg1: u256, arg2: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg4), 13906834397681680383);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg2);
        assert!(arg1 > 0, 13906834414861549567);
        let v0 = calculate_pending_reward_coins(arg0, arg2);
        let v1 = calculate_pending_reward_tokens(arg0, arg2);
        assert!(v0 == 0, 13906834436336386047);
        assert!(v1 == 0, 13906834440631353343);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::vault::send_tokens_to_account(arg2, arg0, arg1, arg4);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::decrement_local_value(arg2, arg0, local_staked_tokens(), arg1);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::set_local_value(arg2, arg0, local_claim_timestamp(), 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_timestamp(arg3));
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::state::decrement_global_value(arg2, global_next_staked_tokens(), arg1);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::event::cycle_unstaked(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

