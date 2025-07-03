module 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool {
    struct UnstakedTokenRecord has drop, store {
        owner: address,
        amount: u64,
        original_token_id: 0x2::object::ID,
        unstake_time: u64,
    }

    struct StakingPool<phantom T0> has key {
        id: 0x2::object::UID,
        total_staked: u64,
        total_veheadal: u64,
        version: u64,
        rewards_pool: 0x2::balance::Balance<T0>,
        last_reward_update: u64,
        staking_records: 0x2::table::Table<address, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::UserStakingInfo<T0>>,
        unstaked_tokens: 0x2::table::Table<address, 0x2::balance::Balance<T0>>,
        unstaked_token_records: 0x2::table::Table<0x2::object::ID, UnstakedTokenRecord>,
        min_stake_amount: u64,
    }

    public(friend) fun claim_unstaked_tokens<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.unstaked_tokens, arg1), 2);
        0x2::table::remove<address, 0x2::balance::Balance<T0>>(&mut arg0.unstaked_tokens, arg1)
    }

    public(friend) fun claim_unstaked_tokens_by_id<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::table::contains<0x2::object::ID, UnstakedTokenRecord>(&arg0.unstaked_token_records, arg1), 2);
        assert!(0x2::table::borrow<0x2::object::ID, UnstakedTokenRecord>(&arg0.unstaked_token_records, arg1).owner == arg2, 3);
        let v0 = 0x2::table::remove<0x2::object::ID, UnstakedTokenRecord>(&mut arg0.unstaked_token_records, arg1);
        let v1 = v0.amount;
        assert!(0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.unstaked_tokens, arg2), 2);
        let v2 = 0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.unstaked_tokens, arg2);
        assert!(0x2::balance::value<T0>(v2) >= v1, 2);
        if (0x2::balance::value<T0>(v2) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::table::remove<address, 0x2::balance::Balance<T0>>(&mut arg0.unstaked_tokens, arg2));
        };
        0x2::balance::split<T0>(v2, v1)
    }

    public(friend) fun create_or_update_staking_info<T0>(arg0: &mut StakingPool<T0>, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::UserStakingInfo<T0>>(&arg0.staking_records, arg1)) {
            let v0 = 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::create<T0>();
            0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::add_stake<T0>(&mut v0, arg3, arg2);
            0x2::table::add<address, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::UserStakingInfo<T0>>(&mut arg0.staking_records, arg1, v0);
        } else {
            0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::add_stake<T0>(0x2::table::borrow_mut<address, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::UserStakingInfo<T0>>(&mut arg0.staking_records, arg1), arg3, arg2);
        };
    }

    public(friend) fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) : StakingPool<T0> {
        StakingPool<T0>{
            id                     : 0x2::object::new(arg0),
            total_staked           : 0,
            total_veheadal         : 0,
            version                : 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::version::get_program_version(),
            rewards_pool           : 0x2::balance::zero<T0>(),
            last_reward_update     : 0,
            staking_records        : 0x2::table::new<address, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::UserStakingInfo<T0>>(arg0),
            unstaked_tokens        : 0x2::table::new<address, 0x2::balance::Balance<T0>>(arg0),
            unstaked_token_records : 0x2::table::new<0x2::object::ID, UnstakedTokenRecord>(arg0),
            min_stake_amount       : 0,
        }
    }

    public fun get_version<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.version
    }

    public fun min_stake_amount<T0>(arg0: &StakingPool<T0>) : u64 {
        arg0.min_stake_amount
    }

    public(friend) fun set_min_stake_amount<T0>(arg0: &mut StakingPool<T0>, arg1: u64) {
        arg0.min_stake_amount = arg1;
    }

    public(friend) fun share_pool<T0>(arg0: StakingPool<T0>) {
        0x2::transfer::share_object<StakingPool<T0>>(arg0);
    }

    public(friend) fun stake<T0>(arg0: &mut StakingPool<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0> {
        let v0 = arg0.min_stake_amount;
        if (v0 > 0) {
            assert!(arg2 >= v0, 4);
        };
        0x2::balance::join<T0>(&mut arg0.rewards_pool, arg1);
        let (v1, v2) = 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::create_veheadal<T0>(arg2, arg3, arg6, 0x2::clock::timestamp_ms(arg5), arg4, arg7);
        let v3 = v1;
        arg0.total_staked = arg0.total_staked + arg2;
        arg0.total_veheadal = arg0.total_veheadal + v2;
        if (!0x2::table::contains<address, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::UserStakingInfo<T0>>(&arg0.staking_records, arg6)) {
            let v4 = 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::create<T0>();
            0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::add_stake<T0>(&mut v4, arg2, 0x2::object::id<0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>>(&v3));
            0x2::table::add<address, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::UserStakingInfo<T0>>(&mut arg0.staking_records, arg6, v4);
        } else {
            0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::add_stake<T0>(0x2::table::borrow_mut<address, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::UserStakingInfo<T0>>(&mut arg0.staking_records, arg6), arg2, 0x2::object::id<0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>>(&v3));
        };
        v3
    }

    public(friend) fun start_decay<T0>(arg0: &mut 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>, arg1: &0x2::clock::Clock) {
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::start_decay<T0>(arg0, arg1);
    }

    public(friend) fun stop_decay<T0>(arg0: &mut 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>, arg1: &0x2::clock::Clock) {
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::stop_decay<T0>(arg0, arg1);
    }

    public(friend) fun unstake<T0>(arg0: &mut StakingPool<T0>, arg1: 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_owner<T0>(&arg1);
        let v1 = 0x2::object::id<0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>>(&arg1);
        let v2 = 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_locked_amount<T0>(&arg1);
        arg0.total_staked = arg0.total_staked - v2;
        arg0.total_veheadal = arg0.total_veheadal - 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_initial_amount<T0>(&arg1);
        assert!(0x2::table::contains<address, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::UserStakingInfo<T0>>(&arg0.staking_records, v0), 1);
        let v3 = 0x2::table::borrow_mut<address, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::UserStakingInfo<T0>>(&mut arg0.staking_records, v0);
        assert!(0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::remove_stake<T0>(v3, v1), 1);
        if (!0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::has_active_stakes<T0>(v3)) {
            0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::destroy_empty<T0>(0x2::table::remove<address, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::UserStakingInfo<T0>>(&mut arg0.staking_records, v0));
        };
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::destroy_veheadal<T0>(arg1);
        if (0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.unstaked_tokens, v0)) {
            0x2::balance::join<T0>(0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.unstaked_tokens, v0), 0x2::balance::split<T0>(&mut arg0.rewards_pool, v2));
        } else {
            0x2::table::add<address, 0x2::balance::Balance<T0>>(&mut arg0.unstaked_tokens, v0, 0x2::balance::split<T0>(&mut arg0.rewards_pool, v2));
        };
        let v4 = UnstakedTokenRecord{
            owner             : v0,
            amount            : v2,
            original_token_id : v1,
            unstake_time      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::table::add<0x2::object::ID, UnstakedTokenRecord>(&mut arg0.unstaked_token_records, v1, v4);
    }

    public(friend) fun unstake_and_claim<T0>(arg0: &mut StakingPool<T0>, arg1: 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_owner<T0>(&arg1);
        let v1 = 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_locked_amount<T0>(&arg1);
        arg0.total_staked = arg0.total_staked - v1;
        arg0.total_veheadal = arg0.total_veheadal - 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_initial_amount<T0>(&arg1);
        assert!(0x2::table::contains<address, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::UserStakingInfo<T0>>(&arg0.staking_records, v0), 1);
        let v2 = 0x2::table::borrow_mut<address, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::UserStakingInfo<T0>>(&mut arg0.staking_records, v0);
        assert!(0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::remove_stake<T0>(v2, 0x2::object::id<0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>>(&arg1)), 1);
        if (!0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::has_active_stakes<T0>(v2)) {
            0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::destroy_empty<T0>(0x2::table::remove<address, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::UserStakingInfo<T0>>(&mut arg0.staking_records, v0));
        };
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::destroy_veheadal<T0>(arg1);
        0x2::balance::split<T0>(&mut arg0.rewards_pool, v1)
    }

    public(friend) fun update_lock_period<T0>(arg0: &mut StakingPool<T0>, arg1: u64, arg2: u64) {
        arg0.total_veheadal = arg0.total_veheadal - arg1 + arg2;
    }

    public(friend) fun update_user_stake<T0>(arg0: &mut StakingPool<T0>, arg1: &0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.rewards_pool, arg2);
        arg0.total_staked = arg0.total_staked + arg3;
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::update_stake_amount<T0>(0x2::table::borrow_mut<address, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::user_staking_info::UserStakingInfo<T0>>(&mut arg0.staking_records, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_owner<T0>(arg1)), 0x2::object::id<0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>>(arg1), arg3);
    }

    public(friend) fun update_version<T0>(arg0: &mut StakingPool<T0>) {
        arg0.version = 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::version::get_program_version();
    }

    // decompiled from Move bytecode v6
}

