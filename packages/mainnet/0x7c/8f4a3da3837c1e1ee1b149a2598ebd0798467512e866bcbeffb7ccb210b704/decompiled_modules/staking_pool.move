module 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::staking_pool {
    struct STAKING_POOL has drop {
        dummy_field: bool,
    }

    struct StakingPool has store, key {
        id: 0x2::object::UID,
        unbond_bucket: 0x2::vec_map::VecMap<u64, u64>,
        total_vote_power: u128,
        last_update_at: u64,
        current_epoch: u64,
        current_global_index: u128,
        epoch_data: 0x2::vec_map::VecMap<u64, PoolRewardData>,
        reward: 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>,
        reward_rate: u128,
        reward_end_at: u64,
        total_reward_allocated: u128,
        reward_last_update_at: u64,
    }

    struct PoolRewardData has drop, store {
        start_index: u128,
        end_index: u128,
    }

    struct UserRewardData has drop, store {
        last_claimed_at: u64,
        last_claimed_epoch: u64,
        last_claimed_index: u128,
        reward_claimed: u128,
    }

    struct UpdatePoolRewardEmissionEvent has copy, drop, store {
        sender: address,
        total_reward: u64,
        reward_end_at: u64,
        reward_rate: u128,
    }

    public(friend) fun split(arg0: &StakingPool, arg1: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken {
        assert!(arg0.last_update_at == 0x2::clock::timestamp_ms(arg3) || arg0.last_update_at == arg0.reward_end_at, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_pool_not_synced());
        assert!(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::get_dynamic_field<UserRewardData>(arg1).last_claimed_at == 0x2::clock::timestamp_ms(arg3), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_reward_not_claimed());
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::split(arg1, arg2, arg4)
    }

    public(friend) fun add_balance(arg0: &mut StakingPool, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg2: u64, arg3: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg4: &0x2::clock::Clock) {
        assert!(arg0.last_update_at == 0x2::clock::timestamp_ms(arg4) || arg0.last_update_at == arg0.reward_end_at, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_pool_not_synced());
        assert!(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::get_dynamic_field<UserRewardData>(arg3).last_claimed_at == 0x2::clock::timestamp_ms(arg4), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_reward_not_claimed());
        let (v0, v1) = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::config_fields(arg1);
        let v2 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::unbond_at(arg3);
        add_to_unbond_bucket(arg0, &v2, arg2);
        arg0.total_vote_power = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::math_u128::add(arg0.total_vote_power, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::vote_power::vote_power_for_range(v0, v1, arg2, 0x2::clock::timestamp_ms(arg4), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::unbond_at(arg3)));
    }

    public(friend) fun add_to_unbond_bucket(arg0: &mut StakingPool, arg1: &u64, arg2: u64) {
        if (0x2::vec_map::contains<u64, u64>(&arg0.unbond_bucket, arg1)) {
            *0x2::vec_map::get_mut<u64, u64>(&mut arg0.unbond_bucket, arg1) = *0x2::vec_map::get<u64, u64>(&arg0.unbond_bucket, arg1) + arg2;
        } else {
            0x2::vec_map::insert<u64, u64>(&mut arg0.unbond_bucket, *arg1, arg2);
        };
    }

    fun assert_pool_synced(arg0: &StakingPool, arg1: &0x2::clock::Clock) {
        assert!(arg0.last_update_at == 0x2::clock::timestamp_ms(arg1) || arg0.last_update_at == arg0.reward_end_at, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_pool_not_synced());
    }

    fun calculate_reward_single_epoch(arg0: &StakingPool, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg2: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg3: u64, arg4: u64) : (u128, u128) {
        let v0 = current_epoch(arg0);
        if (arg4 > v0 || arg4 < arg3) {
            return (0, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::get_dynamic_field<UserRewardData>(arg2).last_claimed_index)
        };
        let v1 = 0x2::vec_map::get<u64, PoolRewardData>(&arg0.epoch_data, &arg4);
        let v2 = v1.end_index;
        let (v3, v4) = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::config_fields(arg1);
        let v5 = if (arg4 == v0) {
            let v6 = current_global_index(arg0);
            v2 = v6;
            v6 - 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::get_dynamic_field<UserRewardData>(arg2).last_claimed_index
        } else if (arg4 == arg3) {
            v1.end_index - 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::get_dynamic_field<UserRewardData>(arg2).last_claimed_index
        } else {
            v1.end_index - v1.start_index
        };
        (0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::math_u128::mul_div_floor(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::vote_power::vote_power_for_epoch_id(v3, v4, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::balance(arg2), arg4, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::unbond_at(arg2)), v5, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::consts::precision()), v2)
    }

    fun calculate_total_vote_power_at_epoch_id(arg0: &StakingPool, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::vote_power::VotePowerConfig, arg2: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::EpochConfig, arg3: u64) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x2::vec_map::length<u64, u64>(&arg0.unbond_bucket)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<u64, u64>(&arg0.unbond_bucket, v0);
            v1 = v1 + 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::vote_power::vote_power_for_epoch_id_ceil(arg1, arg2, *v3, arg3, *v2);
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun claim_reward(arg0: &mut StakingPool, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg2: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT> {
        assert!(arg0.last_update_at == 0x2::clock::timestamp_ms(arg3) || arg0.last_update_at == arg0.reward_end_at, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_pool_not_synced());
        let v0 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::get_dynamic_field<UserRewardData>(arg2);
        let v1 = v0.last_claimed_epoch;
        let v2 = v0.last_claimed_epoch;
        let v3 = 0x2::balance::zero<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>();
        while (v1 <= current_epoch(arg0)) {
            if (v1 != v0.last_claimed_epoch) {
                v2 = v1 - 1;
            };
            let (v4, v5) = calculate_reward_single_epoch(arg0, arg1, arg2, v2, v1);
            let v6 = v4;
            let v7 = 0x1::string::utf8(b"single_epoch_reward");
            0x1::debug::print<0x1::string::String>(&v7);
            0x1::debug::print<u64>(&v1);
            let v8 = 0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg0.reward);
            0x1::debug::print<u64>(&v8);
            0x1::debug::print<u128>(&v6);
            if (v6 > (0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg0.reward) as u128)) {
                v6 = (0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg0.reward) as u128);
            };
            0x2::balance::join<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&mut v3, 0x2::balance::split<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&mut arg0.reward, (v6 as u64)));
            update_user_reward_data(arg2, 0x2::clock::timestamp_ms(arg3), v1, v5, v6);
            v1 = v1 + 1;
        };
        v3
    }

    public(friend) fun claim_reward_single_epoch(arg0: &mut StakingPool, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg2: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT> {
        assert!(arg0.last_update_at == 0x2::clock::timestamp_ms(arg3) || arg0.last_update_at == arg0.reward_end_at, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_pool_not_synced());
        let v0 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::get_dynamic_field<UserRewardData>(arg2);
        let v1 = v0.last_claimed_epoch;
        let v2 = if (v0.last_claimed_index == 0x2::vec_map::get<u64, PoolRewardData>(&arg0.epoch_data, &v1).end_index) {
            v1 + 1
        } else {
            v1
        };
        let (v3, v4) = calculate_reward_single_epoch(arg0, arg1, arg2, v1, v2);
        let v5 = v3;
        update_user_reward_data(arg2, 0x2::clock::timestamp_ms(arg3), v2, v4, v3);
        if (v3 > (0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg0.reward) as u128)) {
            v5 = (0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg0.reward) as u128);
        };
        0x2::balance::split<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&mut arg0.reward, (v5 as u64))
    }

    public fun current_epoch(arg0: &StakingPool) : u64 {
        arg0.current_epoch
    }

    public fun current_global_index(arg0: &StakingPool) : u128 {
        arg0.current_global_index
    }

    public(friend) fun deposit(arg0: &mut StakingPool, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg2: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg3: &0x2::clock::Clock) {
        assert!(arg0.last_update_at == 0x2::clock::timestamp_ms(arg3) || arg0.last_update_at == arg0.reward_end_at, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_pool_not_synced());
        let (v0, v1) = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::config_fields(arg1);
        let v2 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::unbond_at(arg2);
        add_to_unbond_bucket(arg0, &v2, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::balance(arg2));
        arg0.total_vote_power = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::math_u128::add(arg0.total_vote_power, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::vote_power::vote_power_for_range(v0, v1, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::balance(arg2), 0x2::clock::timestamp_ms(arg3), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::unbond_at(arg2)));
        init_user_reward_data(arg2, 0x2::clock::timestamp_ms(arg3), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::epoch_id(v1, 0x2::clock::timestamp_ms(arg3)), arg0.current_global_index);
    }

    public(friend) fun extend(arg0: &mut StakingPool, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg2: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg0.last_update_at == 0x2::clock::timestamp_ms(arg4) || arg0.last_update_at == arg0.reward_end_at, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_pool_not_synced());
        assert!(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::get_dynamic_field<UserRewardData>(arg2).last_claimed_at == 0x2::clock::timestamp_ms(arg4), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_reward_not_claimed());
        let (v0, v1) = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::config_fields(arg1);
        let v2 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::unbond_at(arg2);
        remove_from_unbond_bucket(arg0, &v2, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::balance(arg2));
        add_to_unbond_bucket(arg0, &arg3, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::balance(arg2));
        arg0.total_vote_power = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::math_u128::add(arg0.total_vote_power, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::vote_power::vote_power_for_range(v0, v1, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::balance(arg2), 0x2::clock::timestamp_ms(arg4), arg3) - 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::vote_power::vote_power_for_range(v0, v1, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::balance(arg2), 0x2::clock::timestamp_ms(arg4), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::unbond_at(arg2)));
    }

    public(friend) fun finalize_epoch_and_create_next(arg0: &mut StakingPool, arg1: u64) {
        0x2::vec_map::get_mut<u64, PoolRewardData>(&mut arg0.epoch_data, &arg1).end_index = arg0.current_global_index;
        let v0 = PoolRewardData{
            start_index : arg0.current_global_index,
            end_index   : arg0.current_global_index,
        };
        0x2::vec_map::insert<u64, PoolRewardData>(&mut arg0.epoch_data, arg1 + 1, v0);
    }

    public(friend) fun get_unbond_bucket(arg0: &StakingPool) : 0x2::vec_map::VecMap<u64, u64> {
        arg0.unbond_bucket
    }

    public(friend) fun get_unbond_bucket_entry_by_key(arg0: &StakingPool, arg1: u64) : u64 {
        *0x2::vec_map::get<u64, u64>(&arg0.unbond_bucket, &arg1)
    }

    public(friend) fun get_user_claim_reward_amount(arg0: &StakingPool, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg2: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken) : u64 {
        let v0 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::get_dynamic_field<UserRewardData>(arg2);
        let v1 = v0.last_claimed_epoch;
        let v2 = v0.last_claimed_epoch;
        let v3 = 0;
        while (v1 <= current_epoch(arg0)) {
            if (v1 != v0.last_claimed_epoch) {
                v2 = v1 - 1;
            };
            let (v4, _) = calculate_reward_single_epoch(arg0, arg1, arg2, v2, v1);
            let v6 = v4;
            v1 = v1 + 1;
            if (v4 > (0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg0.reward) as u128)) {
                v6 = (0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg0.reward) as u128);
            };
            v3 = v3 + v6;
        };
        (v3 as u64)
    }

    public fun get_user_reward_data(arg0: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken) : (u64, u64, u128, u128) {
        let v0 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::get_dynamic_field<UserRewardData>(arg0);
        (v0.last_claimed_at, v0.last_claimed_epoch, v0.last_claimed_index, v0.reward_claimed)
    }

    fun init(arg0: STAKING_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StakingPool{
            id                     : 0x2::object::new(arg1),
            unbond_bucket          : 0x2::vec_map::empty<u64, u64>(),
            total_vote_power       : 0,
            last_update_at         : 0,
            current_epoch          : 0,
            current_global_index   : 0,
            epoch_data             : 0x2::vec_map::empty<u64, PoolRewardData>(),
            reward                 : 0x2::balance::zero<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(),
            reward_rate            : 0,
            reward_end_at          : 0,
            total_reward_allocated : 0,
            reward_last_update_at  : 0,
        };
        0x2::transfer::public_transfer<StakingPool>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun init_reward(arg0: &mut StakingPool, arg1: u64) {
        arg0.reward_last_update_at = arg1;
        arg0.reward_end_at = arg1;
    }

    public(friend) fun init_user_reward_data(arg0: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg1: u64, arg2: u64, arg3: u128) {
        let v0 = UserRewardData{
            last_claimed_at    : arg1,
            last_claimed_epoch : arg2,
            last_claimed_index : arg3,
            reward_claimed     : 0,
        };
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::update_dynamic_field<UserRewardData>(arg0, v0);
    }

    public(friend) fun initialize(arg0: &mut StakingPool, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::EpochConfig, arg2: &0x2::clock::Clock) {
        arg0.current_epoch = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::epoch_id(arg1, 0x2::clock::timestamp_ms(arg2));
        arg0.last_update_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = PoolRewardData{
            start_index : 0,
            end_index   : 0,
        };
        0x2::vec_map::insert<u64, PoolRewardData>(&mut arg0.epoch_data, arg0.current_epoch, v0);
    }

    public fun last_update_at(arg0: &StakingPool) : u64 {
        arg0.last_update_at
    }

    public(friend) fun merge(arg0: &mut StakingPool, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg2: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg3: 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg4: &0x2::clock::Clock) {
        assert_pool_synced(arg0, arg4);
        assert!(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::get_dynamic_field<UserRewardData>(arg2).last_claimed_at == 0x2::clock::timestamp_ms(arg4), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_reward_not_claimed());
        assert!(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::get_dynamic_field<UserRewardData>(&arg3).last_claimed_at == 0x2::clock::timestamp_ms(arg4), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_reward_not_claimed());
        let v0 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::balance(&arg3);
        let (v1, v2) = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::config_fields(arg1);
        let v3 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::unbond_at(&arg3);
        remove_from_unbond_bucket(arg0, &v3, v0);
        let v4 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::unbond_at(arg2);
        add_to_unbond_bucket(arg0, &v4, v0);
        arg0.total_vote_power = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::math_u128::add(arg0.total_vote_power, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::math_u128::sub(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::vote_power::vote_power_for_range(v1, v2, v0, 0x2::clock::timestamp_ms(arg4), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::unbond_at(arg2)), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::vote_power::vote_power_for_range(v1, v2, v0, 0x2::clock::timestamp_ms(arg4), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::unbond_at(&arg3))));
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::merge(arg2, arg3);
    }

    public(friend) fun remove_from_unbond_bucket(arg0: &mut StakingPool, arg1: &u64, arg2: u64) {
        assert!(0x2::vec_map::contains<u64, u64>(&arg0.unbond_bucket, arg1), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_unbond_bucket_not_found());
        let v0 = *0x2::vec_map::get<u64, u64>(&arg0.unbond_bucket, arg1);
        assert!(v0 >= arg2, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_amount());
        if (v0 == arg2) {
            let (_, _) = 0x2::vec_map::remove<u64, u64>(&mut arg0.unbond_bucket, arg1);
        } else {
            *0x2::vec_map::get_mut<u64, u64>(&mut arg0.unbond_bucket, arg1) = v0 - arg2;
        };
    }

    public fun reward_end_at(arg0: &StakingPool) : u64 {
        arg0.reward_end_at
    }

    public fun reward_last_update_at(arg0: &StakingPool) : u64 {
        arg0.reward_last_update_at
    }

    public fun reward_rate(arg0: &StakingPool) : u128 {
        arg0.reward_rate
    }

    public(friend) fun sync_or_advance_epoch(arg0: &mut StakingPool, arg1: &0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::VeMMT, arg2: &0x2::clock::Clock) {
        if (arg0.last_update_at >= arg0.reward_end_at) {
            return
        };
        let (v0, v1) = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_mmt::config_fields(arg1);
        let v2 = arg0.current_epoch;
        if (0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::epoch_id(v1, 0x2::clock::timestamp_ms(arg2)) == v2) {
            let v3 = 0x1::u64::min(0x2::clock::timestamp_ms(arg2), arg0.reward_end_at);
            let v4 = ((v3 - arg0.last_update_at) as u128);
            update_global_index(arg0, v4);
            arg0.last_update_at = v3;
            return
        };
        let v5 = 0x1::u64::min(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::epoch::epoch_end(v1, v2), arg0.reward_end_at);
        let v6 = ((v5 - arg0.last_update_at) as u128);
        update_global_index(arg0, v6);
        arg0.last_update_at = v5;
        arg0.current_epoch = v2 + 1;
        arg0.total_vote_power = calculate_total_vote_power_at_epoch_id(arg0, v0, v1, v2 + 1);
        finalize_epoch_and_create_next(arg0, v2);
    }

    public fun total_reward_allocated(arg0: &StakingPool) : u128 {
        arg0.total_reward_allocated
    }

    public fun total_vote_power(arg0: &StakingPool) : u128 {
        arg0.total_vote_power
    }

    public(friend) fun update_global_index(arg0: &mut StakingPool, arg1: u128) {
        if (arg0.total_vote_power == 0 || arg1 == 0) {
            return
        };
        arg0.current_global_index = arg0.current_global_index + 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::math_u128::mul_div_floor(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::math_u128::mul_div_floor(arg1, arg0.reward_rate, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::consts::precision()), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::consts::precision(), arg0.total_vote_power);
    }

    public(friend) fun update_reward_emission(arg0: &mut StakingPool, arg1: 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = arg0.reward_end_at + arg2;
        assert!(v0 > arg0.reward_last_update_at, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_invalid_last_update_time());
        arg0.reward_end_at = v0;
        0x2::balance::join<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&mut arg0.reward, arg1);
        arg0.reward_rate = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::math_u128::mul_div_floor((0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg0.reward) as u128) - arg0.total_reward_allocated, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::consts::precision(), ((arg0.reward_end_at - arg0.reward_last_update_at) as u128));
        let v1 = UpdatePoolRewardEmissionEvent{
            sender        : 0x2::tx_context::sender(arg3),
            total_reward  : 0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg0.reward),
            reward_end_at : arg0.reward_end_at,
            reward_rate   : arg0.reward_rate,
        };
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::event::emit<UpdatePoolRewardEmissionEvent>(v1);
    }

    public(friend) fun update_reward_info(arg0: &mut StakingPool, arg1: u64) {
        if (arg1 > arg0.reward_last_update_at) {
            let v0 = 0x1::u64::min(arg1, arg0.reward_end_at);
            if (v0 > arg0.reward_last_update_at) {
                arg0.total_reward_allocated = arg0.total_reward_allocated + 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::math_u128::mul_div_floor(((v0 - arg0.reward_last_update_at) as u128), arg0.reward_rate, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::consts::precision());
            };
            arg0.reward_last_update_at = arg1;
        };
    }

    public(friend) fun update_user_reward_data(arg0: &mut 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg1: u64, arg2: u64, arg3: u128, arg4: u128) {
        let v0 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::get_dynamic_field_mut<UserRewardData>(arg0);
        v0.last_claimed_at = arg1;
        v0.last_claimed_epoch = arg2;
        v0.last_claimed_index = arg3;
        v0.reward_claimed = v0.reward_claimed + arg4;
    }

    public(friend) fun withdraw(arg0: &mut StakingPool, arg1: 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::VeToken, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT> {
        assert!(arg0.last_update_at == 0x2::clock::timestamp_ms(arg2) || arg0.last_update_at == arg0.reward_end_at, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_pool_not_synced());
        assert!(0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::get_dynamic_field<UserRewardData>(&arg1).last_claimed_at == 0x2::clock::timestamp_ms(arg2), 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::error::e_reward_not_claimed());
        let v0 = 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::unbond_at(&arg1);
        remove_from_unbond_bucket(arg0, &v0, 0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::balance(&arg1));
        0x7c8f4a3da3837c1e1ee1b149a2598ebd0798467512e866bcbeffb7ccb210b704::ve_token::withdraw(arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

