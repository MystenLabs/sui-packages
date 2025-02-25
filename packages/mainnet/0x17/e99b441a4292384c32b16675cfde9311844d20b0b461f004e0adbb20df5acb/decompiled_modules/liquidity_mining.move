module 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::liquidity_mining {
    struct PoolRewardManager has store, key {
        id: 0x2::object::UID,
        total_shares: u64,
        pool_rewards: vector<0x1::option::Option<PoolReward>>,
        last_update_time_ms: u64,
    }

    struct PoolReward has store, key {
        id: 0x2::object::UID,
        pool_reward_manager_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        start_time_ms: u64,
        end_time_ms: u64,
        total_rewards: u64,
        allocated_rewards: 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::Decimal,
        cumulative_rewards_per_share: 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::Decimal,
        num_user_reward_managers: u64,
        additional_fields: 0x2::bag::Bag,
    }

    struct RewardBalance<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct UserRewardManager has store {
        pool_reward_manager_id: 0x2::object::ID,
        share: u64,
        rewards: vector<0x1::option::Option<UserReward>>,
        last_update_time_ms: u64,
    }

    struct UserReward has store {
        pool_reward_id: 0x2::object::ID,
        earned_rewards: 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::Decimal,
        cumulative_rewards_per_share: 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::Decimal,
    }

    public(friend) fun add_pool_reward<T0>(arg0: &mut PoolRewardManager, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::u64::max(arg2, 0x2::clock::timestamp_ms(arg4));
        assert!(arg3 - v0 >= 3600000, 1);
        let v1 = 0x2::bag::new(arg5);
        let v2 = RewardBalance<T0>{dummy_field: false};
        0x2::bag::add<RewardBalance<T0>, 0x2::balance::Balance<T0>>(&mut v1, v2, arg1);
        let v3 = PoolReward{
            id                           : 0x2::object::new(arg5),
            pool_reward_manager_id       : 0x2::object::id<PoolRewardManager>(arg0),
            coin_type                    : 0x1::type_name::get<T0>(),
            start_time_ms                : v0,
            end_time_ms                  : arg3,
            total_rewards                : 0x2::balance::value<T0>(&arg1),
            allocated_rewards            : 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::from(0),
            cumulative_rewards_per_share : 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::from(0),
            num_user_reward_managers     : 0,
            additional_fields            : v1,
        };
        let v4 = find_available_index(arg0);
        assert!(v4 < 50, 3);
        0x1::option::fill<PoolReward>(0x1::vector::borrow_mut<0x1::option::Option<PoolReward>>(&mut arg0.pool_rewards, v4), v3);
    }

    public(friend) fun cancel_pool_reward<T0>(arg0: &mut PoolRewardManager, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        update_pool_reward_manager(arg0, arg2);
        let v0 = 0x1::option::borrow_mut<PoolReward>(0x1::vector::borrow_mut<0x1::option::Option<PoolReward>>(&mut arg0.pool_rewards, arg1));
        v0.end_time_ms = 0x2::clock::timestamp_ms(arg2);
        v0.total_rewards = 0;
        let v1 = RewardBalance<T0>{dummy_field: false};
        0x2::balance::split<T0>(0x2::bag::borrow_mut<RewardBalance<T0>, 0x2::balance::Balance<T0>>(&mut v0.additional_fields, v1), 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::floor(0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::sub(0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::from(v0.total_rewards), v0.allocated_rewards)))
    }

    public(friend) fun change_user_reward_manager_share(arg0: &mut PoolRewardManager, arg1: &mut UserRewardManager, arg2: u64, arg3: &0x2::clock::Clock) {
        update_user_reward_manager(arg0, arg1, arg3, false);
        arg0.total_shares = arg0.total_shares - arg1.share + arg2;
        arg1.share = arg2;
    }

    public(friend) fun claim_rewards<T0>(arg0: &mut PoolRewardManager, arg1: &mut UserRewardManager, arg2: &0x2::clock::Clock, arg3: u64) : 0x2::balance::Balance<T0> {
        update_user_reward_manager(arg0, arg1, arg2, false);
        let v0 = 0x1::option::borrow_mut<PoolReward>(0x1::vector::borrow_mut<0x1::option::Option<PoolReward>>(&mut arg0.pool_rewards, arg3));
        assert!(v0.coin_type == 0x1::type_name::get<T0>(), 2);
        let v1 = 0x1::vector::borrow_mut<0x1::option::Option<UserReward>>(&mut arg1.rewards, arg3);
        let v2 = 0x1::option::borrow_mut<UserReward>(v1);
        let v3 = 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::floor(v2.earned_rewards);
        v2.earned_rewards = 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::sub(v2.earned_rewards, 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::from(v3));
        let v4 = RewardBalance<T0>{dummy_field: false};
        if (0x2::clock::timestamp_ms(arg2) >= v0.end_time_ms) {
            let UserReward {
                pool_reward_id               : _,
                earned_rewards               : _,
                cumulative_rewards_per_share : _,
            } = 0x1::option::extract<UserReward>(v1);
            v0.num_user_reward_managers = v0.num_user_reward_managers - 1;
        };
        0x2::balance::split<T0>(0x2::bag::borrow_mut<RewardBalance<T0>, 0x2::balance::Balance<T0>>(&mut v0.additional_fields, v4), v3)
    }

    public(friend) fun close_pool_reward<T0>(arg0: &mut PoolRewardManager, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let PoolReward {
            id                           : v0,
            pool_reward_manager_id       : _,
            coin_type                    : _,
            start_time_ms                : _,
            end_time_ms                  : v4,
            total_rewards                : _,
            allocated_rewards            : _,
            cumulative_rewards_per_share : _,
            num_user_reward_managers     : v8,
            additional_fields            : v9,
        } = 0x1::option::extract<PoolReward>(0x1::vector::borrow_mut<0x1::option::Option<PoolReward>>(&mut arg0.pool_rewards, arg1));
        let v10 = v9;
        0x2::object::delete(v0);
        assert!(0x2::clock::timestamp_ms(arg2) >= v4, 5);
        assert!(v8 == 0, 4);
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

    public fun last_update_time_ms(arg0: &UserRewardManager) : u64 {
        arg0.last_update_time_ms
    }

    public(friend) fun new_pool_reward_manager(arg0: &mut 0x2::tx_context::TxContext) : PoolRewardManager {
        PoolRewardManager{
            id                  : 0x2::object::new(arg0),
            total_shares        : 0,
            pool_rewards        : 0x1::vector::empty<0x1::option::Option<PoolReward>>(),
            last_update_time_ms : 0,
        }
    }

    public(friend) fun new_user_reward_manager(arg0: &mut PoolRewardManager, arg1: &0x2::clock::Clock) : UserRewardManager {
        let v0 = UserRewardManager{
            pool_reward_manager_id : 0x2::object::id<PoolRewardManager>(arg0),
            share                  : 0,
            rewards                : 0x1::vector::empty<0x1::option::Option<UserReward>>(),
            last_update_time_ms    : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = &mut v0;
        update_user_reward_manager(arg0, v1, arg1, true);
        v0
    }

    public fun pool_reward(arg0: &PoolRewardManager, arg1: u64) : &0x1::option::Option<PoolReward> {
        0x1::vector::borrow<0x1::option::Option<PoolReward>>(&arg0.pool_rewards, arg1)
    }

    public fun pool_reward_id(arg0: &PoolRewardManager, arg1: u64) : 0x2::object::ID {
        0x2::object::id<PoolReward>(0x1::option::borrow<PoolReward>(0x1::vector::borrow<0x1::option::Option<PoolReward>>(&arg0.pool_rewards, arg1)))
    }

    public fun pool_reward_manager_id(arg0: &UserRewardManager) : 0x2::object::ID {
        arg0.pool_reward_manager_id
    }

    public fun shares(arg0: &UserRewardManager) : u64 {
        arg0.share
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
            if (v0 < v3.start_time_ms || arg0.last_update_time_ms >= v3.end_time_ms) {
                v1 = v1 + 1;
                continue
            };
            let v4 = 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::div(0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::mul(0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::from(v3.total_rewards), 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::from(0x1::u64::min(v0, v3.end_time_ms) - 0x1::u64::max(v3.start_time_ms, arg0.last_update_time_ms))), 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::from(v3.end_time_ms - v3.start_time_ms));
            v3.allocated_rewards = 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::add(v3.allocated_rewards, v4);
            v3.cumulative_rewards_per_share = 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::add(v3.cumulative_rewards_per_share, 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::div(v4, 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::from(arg0.total_shares)));
            v1 = v1 + 1;
        };
        arg0.last_update_time_ms = v0;
    }

    fun update_user_reward_manager(arg0: &mut PoolRewardManager, arg1: &mut UserRewardManager, arg2: &0x2::clock::Clock, arg3: bool) {
        assert!(0x2::object::id<PoolRewardManager>(arg0) == arg1.pool_reward_manager_id, 0);
        update_pool_reward_manager(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (!arg3 && v0 == arg1.last_update_time_ms) {
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
            while (0x1::vector::length<0x1::option::Option<UserReward>>(&arg1.rewards) <= v1) {
                0x1::vector::push_back<0x1::option::Option<UserReward>>(&mut arg1.rewards, 0x1::option::none<UserReward>());
            };
            let v4 = 0x1::vector::borrow_mut<0x1::option::Option<UserReward>>(&mut arg1.rewards, v1);
            if (0x1::option::is_none<UserReward>(v4)) {
                if (arg1.last_update_time_ms <= v3.end_time_ms) {
                    let v5 = if (arg1.last_update_time_ms <= v3.start_time_ms) {
                        0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::mul(v3.cumulative_rewards_per_share, 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::from(arg1.share))
                    } else {
                        0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::from(0)
                    };
                    let v6 = UserReward{
                        pool_reward_id               : 0x2::object::id<PoolReward>(v3),
                        earned_rewards               : v5,
                        cumulative_rewards_per_share : v3.cumulative_rewards_per_share,
                    };
                    0x1::option::fill<UserReward>(v4, v6);
                    v3.num_user_reward_managers = v3.num_user_reward_managers + 1;
                };
            } else {
                let v7 = 0x1::option::borrow_mut<UserReward>(v4);
                v7.earned_rewards = 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::add(v7.earned_rewards, 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::mul(0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::sub(v3.cumulative_rewards_per_share, v7.cumulative_rewards_per_share), 0x17e99b441a4292384c32b16675cfde9311844d20b0b461f004e0adbb20df5acb::decimal::from(arg1.share)));
                v7.cumulative_rewards_per_share = v3.cumulative_rewards_per_share;
            };
            v1 = v1 + 1;
        };
        arg1.last_update_time_ms = v0;
    }

    // decompiled from Move bytecode v6
}

