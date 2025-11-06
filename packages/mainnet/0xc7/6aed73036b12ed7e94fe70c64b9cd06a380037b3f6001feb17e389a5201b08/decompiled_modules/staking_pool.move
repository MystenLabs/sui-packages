module 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::staking_pool {
    struct STAKING_POOL has drop {
        dummy_field: bool,
    }

    struct StakingPool has store, key {
        id: 0x2::object::UID,
        unbond_bucket: 0x2::vec_map::VecMap<u64, u64>,
        total_vote_power: u64,
        last_update_at: u64,
        current_epoch: u64,
        current_global_index: u128,
        epoch_data: 0x2::vec_map::VecMap<u64, PoolRewardData>,
        reward: 0x2::balance::Balance<0x666eb9ee40bd5bb7da0e70c92ebcb98d1759d12b2041d581632d983e2ac69d09::mmt::MMT>,
        reward_remain_amount: u128,
        reward_rate: u128,
        init_reward_at: u64,
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

    struct UpdatePoolRewardEmissionEvent has copy, drop {
        sender: address,
        current_reward: u64,
        total_reward_allocated: u128,
        reward_remain_amount: u128,
        reward_end_at: u64,
        reward_rate: u128,
    }

    public(friend) fun add_to_unbond_bucket(arg0: &mut StakingPool, arg1: &u64, arg2: u64) {
        if (0x2::vec_map::contains<u64, u64>(&arg0.unbond_bucket, arg1)) {
            *0x2::vec_map::get_mut<u64, u64>(&mut arg0.unbond_bucket, arg1) = *0x2::vec_map::get<u64, u64>(&arg0.unbond_bucket, arg1) + arg2;
        } else {
            0x2::vec_map::insert<u64, u64>(&mut arg0.unbond_bucket, *arg1, arg2);
        };
    }

    fun assert_pool_synced(arg0: &StakingPool, arg1: &0x2::clock::Clock) {
        assert!(arg0.last_update_at == 0x2::clock::timestamp_ms(arg1) || arg0.last_update_at == arg0.reward_end_at, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::error::e_pool_not_synced());
    }

    fun assert_reward_claimed(arg0: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::VeToken, arg1: &0x2::clock::Clock) {
        assert!(0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::get_dynamic_field<UserRewardData>(arg0).last_claimed_at == 0x2::clock::timestamp_ms(arg1), 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::error::e_reward_not_claimed());
    }

    public fun calculate_epoch_total_vote_power(arg0: &StakingPool, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::VeMMT, arg2: u64) : u64 {
        calculate_total_vote_power_at_epoch_id(arg0, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::vp_config(arg1), 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::ep_config(arg1), arg2)
    }

    fun calculate_reward_single_epoch(arg0: &StakingPool, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::VeMMT, arg2: &mut 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::VeToken, arg3: u64, arg4: u128, arg5: u64) : (u128, u128) {
        if (arg5 < arg3) {
            return (0, arg4)
        };
        let v0 = 0x2::vec_map::get<u64, PoolRewardData>(&arg0.epoch_data, &arg5);
        let v1 = v0.end_index;
        let (_, v3) = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::config_fields(arg1);
        let v4 = if (arg5 == current_epoch(arg0)) {
            let v5 = current_global_index(arg0);
            v1 = v5;
            v5 - arg4
        } else if (arg5 == arg3) {
            v0.end_index - arg4
        } else {
            v0.end_index - v0.start_index
        };
        (0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::math_u128::mul_div_floor((0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::calculate_ve_vote_power(arg2, arg1, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::balance(arg2), 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::epoch_start(v3, arg5)) as u128), v4, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::consts::precision()), v1)
    }

    fun calculate_total_vote_power_at_epoch_id(arg0: &StakingPool, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::vote_power::VotePowerConfig, arg2: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::EpochConfig, arg3: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x2::vec_map::length<u64, u64>(&arg0.unbond_bucket)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<u64, u64>(&arg0.unbond_bucket, v0);
            let v4 = *v2;
            let v5 = if (v4 == 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::max_bond_unbond_at()) {
                0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::vote_power::vote_power_for_max_bond(*v3)
            } else {
                0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::vote_power::vote_power_for_epoch_id_ceil(arg1, arg2, *v3, arg3, v4)
            };
            v1 = v1 + v5;
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun claim_reward(arg0: &mut StakingPool, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::VeMMT, arg2: &mut 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::VeToken, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<0x666eb9ee40bd5bb7da0e70c92ebcb98d1759d12b2041d581632d983e2ac69d09::mmt::MMT> {
        assert_pool_synced(arg0, arg3);
        let (v0, v1) = get_user_claim_reward_data(arg0, arg1, arg2);
        let v2 = v0;
        if (v0 > (0x2::balance::value<0x666eb9ee40bd5bb7da0e70c92ebcb98d1759d12b2041d581632d983e2ac69d09::mmt::MMT>(&arg0.reward) as u128)) {
            v2 = (0x2::balance::value<0x666eb9ee40bd5bb7da0e70c92ebcb98d1759d12b2041d581632d983e2ac69d09::mmt::MMT>(&arg0.reward) as u128);
        };
        update_user_reward_data(arg2, 0x2::clock::timestamp_ms(arg3), current_epoch(arg0), v1, v2);
        0x2::balance::split<0x666eb9ee40bd5bb7da0e70c92ebcb98d1759d12b2041d581632d983e2ac69d09::mmt::MMT>(&mut arg0.reward, (v2 as u64))
    }

    public(friend) fun claim_reward_single_epoch(arg0: &mut StakingPool, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::VeMMT, arg2: &mut 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::VeToken, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<0x666eb9ee40bd5bb7da0e70c92ebcb98d1759d12b2041d581632d983e2ac69d09::mmt::MMT> {
        assert_pool_synced(arg0, arg3);
        let v0 = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::get_dynamic_field<UserRewardData>(arg2);
        let v1 = v0.last_claimed_epoch;
        let v2 = if (v0.last_claimed_index == 0x2::vec_map::get<u64, PoolRewardData>(&arg0.epoch_data, &v1).end_index) {
            v1 + 1
        } else {
            v1
        };
        let (v3, v4) = calculate_reward_single_epoch(arg0, arg1, arg2, v1, v0.last_claimed_index, v2);
        let v5 = v3;
        update_user_reward_data(arg2, 0x2::clock::timestamp_ms(arg3), v2, v4, v3);
        if (v3 > (0x2::balance::value<0x666eb9ee40bd5bb7da0e70c92ebcb98d1759d12b2041d581632d983e2ac69d09::mmt::MMT>(&arg0.reward) as u128)) {
            v5 = (0x2::balance::value<0x666eb9ee40bd5bb7da0e70c92ebcb98d1759d12b2041d581632d983e2ac69d09::mmt::MMT>(&arg0.reward) as u128);
        };
        0x2::balance::split<0x666eb9ee40bd5bb7da0e70c92ebcb98d1759d12b2041d581632d983e2ac69d09::mmt::MMT>(&mut arg0.reward, (v5 as u64))
    }

    public fun current_epoch(arg0: &StakingPool) : u64 {
        arg0.current_epoch
    }

    public fun current_global_index(arg0: &StakingPool) : u128 {
        arg0.current_global_index
    }

    public(friend) fun deposit(arg0: &mut StakingPool, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::VeMMT, arg2: &mut 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::VeToken, arg3: &0x2::clock::Clock) {
        assert_pool_synced(arg0, arg3);
        assert!(!is_ve_staked(arg2), 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::error::e_ve_already_staked());
        let (_, v1) = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::config_fields(arg1);
        let v2 = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::unbond_at(arg2);
        add_to_unbond_bucket(arg0, &v2, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::balance(arg2));
        arg0.total_vote_power = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::math_u64::add(arg0.total_vote_power, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::calculate_ve_vote_power(arg2, arg1, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::balance(arg2), 0x2::clock::timestamp_ms(arg3)));
        init_user_reward_data(arg2, 0x2::clock::timestamp_ms(arg3), 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::epoch_id(v1, 0x2::clock::timestamp_ms(arg3)), arg0.current_global_index);
    }

    public(friend) fun finalize_epoch_and_create_next(arg0: &mut StakingPool, arg1: u64) {
        0x2::vec_map::get_mut<u64, PoolRewardData>(&mut arg0.epoch_data, &arg1).end_index = arg0.current_global_index;
        let v0 = PoolRewardData{
            start_index : arg0.current_global_index,
            end_index   : arg0.current_global_index,
        };
        0x2::vec_map::insert<u64, PoolRewardData>(&mut arg0.epoch_data, arg1 + 1, v0);
    }

    public fun get_epoch_data_by_epoch_id(arg0: &StakingPool, arg1: u64) : (u128, u128) {
        let v0 = 0x2::vec_map::get<u64, PoolRewardData>(&arg0.epoch_data, &arg1);
        (v0.start_index, v0.end_index)
    }

    public(friend) fun get_unbond_bucket(arg0: &StakingPool) : 0x2::vec_map::VecMap<u64, u64> {
        arg0.unbond_bucket
    }

    public(friend) fun get_unbond_bucket_entry_by_key(arg0: &StakingPool, arg1: u64) : u64 {
        *0x2::vec_map::get<u64, u64>(&arg0.unbond_bucket, &arg1)
    }

    public(friend) fun get_user_claim_reward_data(arg0: &StakingPool, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::VeMMT, arg2: &mut 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::VeToken) : (u128, u128) {
        let v0 = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::get_dynamic_field<UserRewardData>(arg2);
        let v1 = v0.last_claimed_epoch;
        v1 = v0.last_claimed_epoch;
        let v2 = 0;
        let v3 = v0.last_claimed_index;
        while (v1 <= current_epoch(arg0)) {
            let (v4, v5) = calculate_reward_single_epoch(arg0, arg1, arg2, v1, v3, v1);
            v1 = v1 + 1;
            v2 = v2 + v4;
            v3 = v5;
        };
        (v2, v3)
    }

    public fun get_user_reward_data(arg0: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::VeToken) : (u64, u64, u128, u128) {
        let v0 = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::get_dynamic_field<UserRewardData>(arg0);
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
            reward                 : 0x2::balance::zero<0x666eb9ee40bd5bb7da0e70c92ebcb98d1759d12b2041d581632d983e2ac69d09::mmt::MMT>(),
            reward_remain_amount   : 0,
            reward_rate            : 0,
            init_reward_at         : 0,
            reward_end_at          : 0,
            total_reward_allocated : 0,
            reward_last_update_at  : 0,
        };
        0x2::transfer::share_object<StakingPool>(v0);
    }

    public(friend) fun init_reward(arg0: &mut StakingPool, arg1: u64) {
        arg0.reward_last_update_at = arg1;
        arg0.init_reward_at = arg1;
        arg0.reward_end_at = arg1;
    }

    public fun init_reward_at(arg0: &StakingPool) : u64 {
        arg0.init_reward_at
    }

    public(friend) fun init_user_reward_data(arg0: &mut 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::VeToken, arg1: u64, arg2: u64, arg3: u128) {
        let v0 = UserRewardData{
            last_claimed_at    : arg1,
            last_claimed_epoch : arg2,
            last_claimed_index : arg3,
            reward_claimed     : 0,
        };
        0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::update_dynamic_field<UserRewardData>(arg0, v0);
    }

    public(friend) fun initialize(arg0: &mut StakingPool, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::EpochConfig, arg2: &0x2::clock::Clock) {
        arg0.current_epoch = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::epoch_id(arg1, 0x2::clock::timestamp_ms(arg2));
        arg0.last_update_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = PoolRewardData{
            start_index : 0,
            end_index   : 0,
        };
        0x2::vec_map::insert<u64, PoolRewardData>(&mut arg0.epoch_data, arg0.current_epoch, v0);
    }

    public(friend) fun is_ve_staked(arg0: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::VeToken) : bool {
        0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::has_dynamic_field<UserRewardData>(arg0)
    }

    public fun last_update_at(arg0: &StakingPool) : u64 {
        arg0.last_update_at
    }

    public(friend) fun remove_from_unbond_bucket(arg0: &mut StakingPool, arg1: &u64, arg2: u64) {
        assert!(0x2::vec_map::contains<u64, u64>(&arg0.unbond_bucket, arg1), 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::error::e_unbond_bucket_not_found());
        let v0 = *0x2::vec_map::get<u64, u64>(&arg0.unbond_bucket, arg1);
        assert!(v0 >= arg2, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::error::e_invalid_amount());
        if (v0 == arg2) {
            let (_, _) = 0x2::vec_map::remove<u64, u64>(&mut arg0.unbond_bucket, arg1);
        } else {
            *0x2::vec_map::get_mut<u64, u64>(&mut arg0.unbond_bucket, arg1) = v0 - arg2;
        };
    }

    public fun reward_data(arg0: &StakingPool) : (u64, u64, u64, u64, u128, u128, u128) {
        (arg0.init_reward_at, arg0.reward_end_at, arg0.reward_last_update_at, 0x2::balance::value<0x666eb9ee40bd5bb7da0e70c92ebcb98d1759d12b2041d581632d983e2ac69d09::mmt::MMT>(&arg0.reward), arg0.reward_remain_amount, arg0.reward_rate, arg0.total_reward_allocated)
    }

    fun should_skip_index_update(arg0: &StakingPool, arg1: u128, arg2: u64) : bool {
        if (arg0.total_vote_power == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else if (arg0.reward_rate == 0) {
            true
        } else if (arg0.reward_end_at != 0 && arg0.last_update_at >= arg0.reward_end_at) {
            true
        } else {
            arg0.init_reward_at > arg2
        }
    }

    public(friend) fun sync_or_advance_epoch(arg0: &mut StakingPool, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::VeMMT, arg2: &0x2::clock::Clock) {
        let (v0, v1) = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::config_fields(arg1);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = arg0.current_epoch;
        let v4 = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::epoch_id(v1, v2);
        if (v4 == v3) {
            let v5 = if (arg0.reward_end_at == 0) {
                v2
            } else {
                0x1::u64::min(v2, arg0.reward_end_at)
            };
            let v6 = ((v5 - arg0.last_update_at) as u128);
            update_global_index(arg0, v6, v2);
            arg0.last_update_at = v5;
            0x2::vec_map::get_mut<u64, PoolRewardData>(&mut arg0.epoch_data, &v4).end_index = arg0.current_global_index;
            return
        };
        let v7 = if (arg0.reward_end_at == 0) {
            0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::epoch_end(v1, v3)
        } else {
            0x1::u64::min(0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::epoch_end(v1, v3), arg0.reward_end_at)
        };
        let v8 = ((v7 - arg0.last_update_at) as u128);
        update_global_index(arg0, v8, v2);
        arg0.last_update_at = v7;
        transition_to_next_epoch(arg0, v0, v1, v3);
    }

    public fun total_vote_power(arg0: &StakingPool) : u64 {
        arg0.total_vote_power
    }

    public(friend) fun transition_to_next_epoch(arg0: &mut StakingPool, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::vote_power::VotePowerConfig, arg2: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::epoch::EpochConfig, arg3: u64) {
        arg0.current_epoch = arg3 + 1;
        arg0.total_vote_power = calculate_total_vote_power_at_epoch_id(arg0, arg1, arg2, arg3 + 1);
        finalize_epoch_and_create_next(arg0, arg3);
    }

    public(friend) fun update_global_index(arg0: &mut StakingPool, arg1: u128, arg2: u64) {
        if (should_skip_index_update(arg0, arg1, arg2)) {
            return
        };
        arg0.current_global_index = arg0.current_global_index + 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::math_u128::mul_div_floor(arg1, arg0.reward_rate, (arg0.total_vote_power as u128));
    }

    public(friend) fun update_reward_emission(arg0: &mut StakingPool, arg1: 0x2::balance::Balance<0x666eb9ee40bd5bb7da0e70c92ebcb98d1759d12b2041d581632d983e2ac69d09::mmt::MMT>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = arg0.reward_end_at + arg2;
        assert!(v0 > arg0.reward_last_update_at, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::error::e_invalid_last_update_time());
        arg0.reward_end_at = v0;
        arg0.reward_remain_amount = arg0.reward_remain_amount + (0x2::balance::value<0x666eb9ee40bd5bb7da0e70c92ebcb98d1759d12b2041d581632d983e2ac69d09::mmt::MMT>(&arg1) as u128);
        0x2::balance::join<0x666eb9ee40bd5bb7da0e70c92ebcb98d1759d12b2041d581632d983e2ac69d09::mmt::MMT>(&mut arg0.reward, arg1);
        arg0.reward_rate = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::math_u128::mul_div_floor(arg0.reward_remain_amount, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::consts::precision(), ((arg0.reward_end_at - arg0.reward_last_update_at) as u128));
        let v1 = UpdatePoolRewardEmissionEvent{
            sender                 : 0x2::tx_context::sender(arg3),
            current_reward         : 0x2::balance::value<0x666eb9ee40bd5bb7da0e70c92ebcb98d1759d12b2041d581632d983e2ac69d09::mmt::MMT>(&arg0.reward),
            total_reward_allocated : arg0.total_reward_allocated,
            reward_remain_amount   : arg0.reward_remain_amount,
            reward_end_at          : arg0.reward_end_at,
            reward_rate            : arg0.reward_rate,
        };
        0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::event::emit<UpdatePoolRewardEmissionEvent>(v1);
    }

    public(friend) fun update_reward_info(arg0: &mut StakingPool, arg1: u64) {
        if (arg1 > arg0.reward_last_update_at) {
            let v0 = 0x1::u64::min(arg1, arg0.reward_end_at);
            if (v0 > arg0.reward_last_update_at) {
                let v1 = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::math_u128::mul_div_floor(((v0 - arg0.reward_last_update_at) as u128), arg0.reward_rate, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::consts::precision());
                arg0.total_reward_allocated = arg0.total_reward_allocated + v1;
                arg0.reward_remain_amount = arg0.reward_remain_amount - v1;
            };
            arg0.reward_last_update_at = arg1;
        };
    }

    public(friend) fun update_user_reward_data(arg0: &mut 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::VeToken, arg1: u64, arg2: u64, arg3: u128, arg4: u128) {
        let v0 = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::get_dynamic_field_mut<UserRewardData>(arg0);
        v0.last_claimed_at = arg1;
        v0.last_claimed_epoch = arg2;
        v0.last_claimed_index = arg3;
        v0.reward_claimed = v0.reward_claimed + arg4;
    }

    public(friend) fun withdraw(arg0: &mut StakingPool, arg1: &0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_mmt::VeMMT, arg2: &mut 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::VeToken, arg3: &0x2::clock::Clock) {
        assert_pool_synced(arg0, arg3);
        assert!(is_ve_staked(arg2), 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::error::e_ve_not_staked());
        assert_reward_claimed(arg2, arg3);
        let v0 = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::unbond_at(arg2);
        remove_from_unbond_bucket(arg0, &v0, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::balance(arg2));
        arg0.total_vote_power = 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::math_u64::sub(arg0.total_vote_power, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::calculate_ve_vote_power(arg2, arg1, 0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::balance(arg2), 0x2::clock::timestamp_ms(arg3)));
        0xc76aed73036b12ed7e94fe70c64b9cd06a380037b3f6001feb17e389a5201b08::ve_token::remove_dynamic_field<UserRewardData>(arg2);
    }

    // decompiled from Move bytecode v6
}

