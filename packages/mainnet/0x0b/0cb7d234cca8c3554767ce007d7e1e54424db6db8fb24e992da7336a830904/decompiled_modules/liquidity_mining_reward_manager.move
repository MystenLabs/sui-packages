module 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::liquidity_mining_reward_manager {
    struct PoolRewardManager has store, key {
        id: 0x2::object::UID,
        total_shares: u64,
        pool_rewards: vector<0x1::option::Option<PoolReward>>,
        last_update_time_ms: u64,
        obligation_reward_managers: 0x2::table::Table<0x2::object::ID, ObligationRewardManager>,
    }

    struct PoolReward has store, key {
        id: 0x2::object::UID,
        pool_reward_manager_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        start_time_ms: u64,
        end_time_ms: u64,
        total_rewards: u64,
        allocated_rewards: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        cumulative_rewards_per_share: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        num_obligation_reward_managers: u64,
        additional_fields: 0x2::bag::Bag,
    }

    struct RewardBalance<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct ObligationRewardManager has store {
        share: u64,
        rewards: vector<0x1::option::Option<ObligationReward>>,
        last_update_time_ms: u64,
    }

    struct ObligationReward has store {
        pool_reward_id: 0x2::object::ID,
        earned_rewards: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
        cumulative_rewards_per_share: 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal,
    }

    public(friend) fun add_pool_reward<T0>(arg0: &mut PoolRewardManager, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg4), 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::liquidity_mining_invalid_start_time());
        assert!(arg3 - arg2 >= 3600000, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::liquidity_mining_invalid_time());
        let v0 = 0x2::bag::new(arg5);
        let v1 = RewardBalance<T0>{dummy_field: false};
        0x2::bag::add<RewardBalance<T0>, 0x2::balance::Balance<T0>>(&mut v0, v1, arg1);
        let v2 = PoolReward{
            id                             : 0x2::object::new(arg5),
            pool_reward_manager_id         : 0x2::object::id<PoolRewardManager>(arg0),
            coin_type                      : 0x1::type_name::with_defining_ids<T0>(),
            start_time_ms                  : arg2,
            end_time_ms                    : arg3,
            total_rewards                  : 0x2::balance::value<T0>(&arg1),
            allocated_rewards              : 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from(0),
            cumulative_rewards_per_share   : 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from(0),
            num_obligation_reward_managers : 0,
            additional_fields              : v0,
        };
        let v3 = find_available_index(arg0);
        assert!(v3 < 50, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::liquidity_mining_max_concurrent_pool_rewards_violated());
        0x1::option::fill<PoolReward>(0x1::vector::borrow_mut<0x1::option::Option<PoolReward>>(&mut arg0.pool_rewards, v3), v2);
    }

    public(friend) fun borrow_obligation_reward_managers(arg0: &PoolRewardManager) : &0x2::table::Table<0x2::object::ID, ObligationRewardManager> {
        &arg0.obligation_reward_managers
    }

    public(friend) fun cancel_pool_reward<T0>(arg0: &mut PoolRewardManager, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        update_pool_reward_manager(arg0, arg2);
        let v0 = 0x1::option::borrow_mut<PoolReward>(0x1::vector::borrow_mut<0x1::option::Option<PoolReward>>(&mut arg0.pool_rewards, arg1));
        v0.end_time_ms = 0x2::clock::timestamp_ms(arg2);
        v0.total_rewards = 0;
        let v1 = RewardBalance<T0>{dummy_field: false};
        0x2::balance::split<T0>(0x2::bag::borrow_mut<RewardBalance<T0>, 0x2::balance::Balance<T0>>(&mut v0.additional_fields, v1), 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::floor(0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::sub(0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from(v0.total_rewards), v0.allocated_rewards)))
    }

    public(friend) fun change_obligation_reward_manager_share(arg0: &mut PoolRewardManager, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) {
        update_obligation_reward_manager(arg0, arg1, arg3, false);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, ObligationRewardManager>(&mut arg0.obligation_reward_managers, arg1);
        arg0.total_shares = arg0.total_shares - v0.share + arg2;
        v0.share = arg2;
    }

    public(friend) fun claim_rewards<T0>(arg0: &mut PoolRewardManager, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: u64) : 0x2::balance::Balance<T0> {
        update_obligation_reward_manager(arg0, arg1, arg2, false);
        let v0 = 0x1::option::borrow_mut<PoolReward>(0x1::vector::borrow_mut<0x1::option::Option<PoolReward>>(&mut arg0.pool_rewards, arg3));
        assert!(v0.coin_type == 0x1::type_name::with_defining_ids<T0>(), 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::liquidity_mining_invalid_type());
        let v1 = 0x1::vector::borrow_mut<0x1::option::Option<ObligationReward>>(&mut 0x2::table::borrow_mut<0x2::object::ID, ObligationRewardManager>(&mut arg0.obligation_reward_managers, arg1).rewards, arg3);
        assert!(0x1::option::is_some<ObligationReward>(v1), 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::liquidity_mining_no_reward_to_claim());
        let v2 = 0x1::option::borrow_mut<ObligationReward>(v1);
        let v3 = 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::floor(v2.earned_rewards);
        v2.earned_rewards = 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::sub(v2.earned_rewards, 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from(v3));
        let v4 = RewardBalance<T0>{dummy_field: false};
        if (0x2::clock::timestamp_ms(arg2) >= v0.end_time_ms) {
            let ObligationReward {
                pool_reward_id               : _,
                earned_rewards               : _,
                cumulative_rewards_per_share : _,
            } = 0x1::option::extract<ObligationReward>(v1);
            v0.num_obligation_reward_managers = v0.num_obligation_reward_managers - 1;
        };
        0x2::balance::split<T0>(0x2::bag::borrow_mut<RewardBalance<T0>, 0x2::balance::Balance<T0>>(&mut v0.additional_fields, v4), v3)
    }

    public(friend) fun close_pool_reward<T0>(arg0: &mut PoolRewardManager, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let PoolReward {
            id                             : v0,
            pool_reward_manager_id         : _,
            coin_type                      : _,
            start_time_ms                  : _,
            end_time_ms                    : v4,
            total_rewards                  : _,
            allocated_rewards              : _,
            cumulative_rewards_per_share   : _,
            num_obligation_reward_managers : v8,
            additional_fields              : v9,
        } = 0x1::option::extract<PoolReward>(0x1::vector::borrow_mut<0x1::option::Option<PoolReward>>(&mut arg0.pool_rewards, arg1));
        let v10 = v9;
        0x2::object::delete(v0);
        assert!(0x2::clock::timestamp_ms(arg2) >= v4, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::liquidity_mining_pool_reward_period_not_over());
        assert!(v8 == 0, 0xb0cb7d234cca8c3554767ce007d7e1e54424db6db8fb24e992da7336a830904::error::liquidity_mining_not_all_rewards_claimed());
        let v11 = RewardBalance<T0>{dummy_field: false};
        0x2::bag::destroy_empty(v10);
        0x2::bag::remove<RewardBalance<T0>, 0x2::balance::Balance<T0>>(&mut v10, v11)
    }

    public fun end_time_ms(arg0: &PoolReward) : u64 {
        arg0.end_time_ms
    }

    fun find_available_index(arg0: &mut PoolRewardManager) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::option::Option<PoolReward>>(&arg0.pool_rewards)) {
            if (0x1::option::is_none<PoolReward>(0x1::vector::borrow<0x1::option::Option<PoolReward>>(&arg0.pool_rewards, v0))) {
                return v0
            };
            v0 = v0 + 1;
        };
        0x1::vector::push_back<0x1::option::Option<PoolReward>>(&mut arg0.pool_rewards, 0x1::option::none<PoolReward>());
        v0
    }

    public fun last_update_time_ms(arg0: &ObligationRewardManager) : u64 {
        arg0.last_update_time_ms
    }

    public(friend) fun new_obligation_reward_manager(arg0: &mut PoolRewardManager, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = ObligationRewardManager{
            share               : 0,
            rewards             : 0x1::vector::empty<0x1::option::Option<ObligationReward>>(),
            last_update_time_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::table::add<0x2::object::ID, ObligationRewardManager>(&mut arg0.obligation_reward_managers, arg1, v0);
        update_obligation_reward_manager(arg0, arg1, arg2, true);
    }

    public(friend) fun new_pool_reward_manager(arg0: &mut 0x2::tx_context::TxContext) : PoolRewardManager {
        PoolRewardManager{
            id                         : 0x2::object::new(arg0),
            total_shares               : 0,
            pool_rewards               : 0x1::vector::empty<0x1::option::Option<PoolReward>>(),
            last_update_time_ms        : 0,
            obligation_reward_managers : 0x2::table::new<0x2::object::ID, ObligationRewardManager>(arg0),
        }
    }

    public fun pool_reward(arg0: &PoolRewardManager, arg1: u64) : &0x1::option::Option<PoolReward> {
        0x1::vector::borrow<0x1::option::Option<PoolReward>>(&arg0.pool_rewards, arg1)
    }

    public fun pool_reward_id(arg0: &PoolRewardManager, arg1: u64) : 0x2::object::ID {
        0x2::object::id<PoolReward>(0x1::option::borrow<PoolReward>(0x1::vector::borrow<0x1::option::Option<PoolReward>>(&arg0.pool_rewards, arg1)))
    }

    public fun shares(arg0: &ObligationRewardManager) : u64 {
        arg0.share
    }

    public fun total_shares(arg0: &PoolRewardManager) : u64 {
        arg0.total_shares
    }

    fun update_obligation_reward_manager(arg0: &mut PoolRewardManager, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: bool) {
        update_pool_reward_manager(arg0, arg2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, ObligationRewardManager>(&mut arg0.obligation_reward_managers, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (!arg3 && v1 == v0.last_update_time_ms) {
            return
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::option::Option<PoolReward>>(&arg0.pool_rewards)) {
            let v3 = 0x1::vector::borrow_mut<0x1::option::Option<PoolReward>>(&mut arg0.pool_rewards, v2);
            if (0x1::option::is_none<PoolReward>(v3)) {
                v2 = v2 + 1;
                continue
            };
            let v4 = 0x1::option::borrow_mut<PoolReward>(v3);
            while (0x1::vector::length<0x1::option::Option<ObligationReward>>(&v0.rewards) <= v2) {
                0x1::vector::push_back<0x1::option::Option<ObligationReward>>(&mut v0.rewards, 0x1::option::none<ObligationReward>());
            };
            let v5 = 0x1::vector::borrow_mut<0x1::option::Option<ObligationReward>>(&mut v0.rewards, v2);
            if (0x1::option::is_none<ObligationReward>(v5)) {
                if (v0.last_update_time_ms <= v4.end_time_ms) {
                    let v6 = if (v0.last_update_time_ms <= v4.start_time_ms) {
                        0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::mul(v4.cumulative_rewards_per_share, 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from(v0.share))
                    } else {
                        0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from(0)
                    };
                    let v7 = ObligationReward{
                        pool_reward_id               : 0x2::object::id<PoolReward>(v4),
                        earned_rewards               : v6,
                        cumulative_rewards_per_share : v4.cumulative_rewards_per_share,
                    };
                    0x1::option::fill<ObligationReward>(v5, v7);
                    v4.num_obligation_reward_managers = v4.num_obligation_reward_managers + 1;
                };
            } else {
                let v8 = 0x1::option::borrow_mut<ObligationReward>(v5);
                v8.earned_rewards = 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::add(v8.earned_rewards, 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::mul(0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::sub(v4.cumulative_rewards_per_share, v8.cumulative_rewards_per_share), 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from(v0.share)));
                v8.cumulative_rewards_per_share = v4.cumulative_rewards_per_share;
            };
            v2 = v2 + 1;
        };
        v0.last_update_time_ms = v1;
    }

    fun update_pool_reward_manager(arg0: &mut PoolRewardManager, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 == arg0.last_update_time_ms) {
            return
        };
        if (arg0.total_shares == 0) {
            arg0.last_update_time_ms = v0;
            return
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::option::Option<PoolReward>>(&arg0.pool_rewards)) {
            let v2 = 0x1::vector::borrow_mut<0x1::option::Option<PoolReward>>(&mut arg0.pool_rewards, v1);
            if (0x1::option::is_none<PoolReward>(v2)) {
                v1 = v1 + 1;
                continue
            };
            let v3 = 0x1::option::borrow_mut<PoolReward>(v2);
            if (v0 <= v3.start_time_ms || arg0.last_update_time_ms >= v3.end_time_ms) {
                v1 = v1 + 1;
                continue
            };
            let v4 = 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::div(0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::mul(0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from(v3.total_rewards), 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from(0x1::u64::min(v0, v3.end_time_ms) - 0x1::u64::max(v3.start_time_ms, arg0.last_update_time_ms))), 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from(v3.end_time_ms - v3.start_time_ms));
            v3.allocated_rewards = 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::add(v3.allocated_rewards, v4);
            v3.cumulative_rewards_per_share = 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::add(v3.cumulative_rewards_per_share, 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::div(v4, 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::from(arg0.total_shares)));
            v1 = v1 + 1;
        };
        arg0.last_update_time_ms = v0;
    }

    // decompiled from Move bytecode v6
}

