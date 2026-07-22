module 0xe0399738759cefcece94a4568f46ddf107abe84aa3a014957ce82adbadfbc785::liquidity_mining_reward_manager {
    struct PoolRewardManager has store, key {
        id: 0x2::object::UID,
        total_shares: u64,
        pool_rewards: vector<0x1::option::Option<PoolReward>>,
        last_update_time_ms: u64,
        position_reward_managers: 0x2::table::Table<0x2::object::ID, PositionRewardManager>,
    }

    struct PoolReward has store, key {
        id: 0x2::object::UID,
        pool_reward_manager_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        start_time_ms: u64,
        end_time_ms: u64,
        total_rewards: u64,
        allocated_rewards: 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::Decimal,
        cumulative_rewards_per_share: 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::Decimal,
        num_position_reward_managers: u64,
        additional_fields: 0x2::bag::Bag,
    }

    struct RewardBalance<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PositionRewardManager has store {
        share: u64,
        rewards: vector<0x1::option::Option<PositionReward>>,
        last_update_time_ms: u64,
    }

    struct PositionReward has store {
        pool_reward_id: 0x2::object::ID,
        earned_rewards: 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::Decimal,
        cumulative_rewards_per_share: 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::Decimal,
    }

    public(friend) fun add_pool_reward<T0>(arg0: &mut PoolRewardManager, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg4), 0xe0399738759cefcece94a4568f46ddf107abe84aa3a014957ce82adbadfbc785::errors::liquidity_mining_invalid_start_time());
        assert!(arg3 - arg2 >= 60000, 0xe0399738759cefcece94a4568f46ddf107abe84aa3a014957ce82adbadfbc785::errors::liquidity_mining_invalid_time());
        let v0 = 0x2::bag::new(arg5);
        let v1 = RewardBalance<T0>{dummy_field: false};
        0x2::bag::add<RewardBalance<T0>, 0x2::balance::Balance<T0>>(&mut v0, v1, arg1);
        let v2 = PoolReward{
            id                           : 0x2::object::new(arg5),
            pool_reward_manager_id       : 0x2::object::id<PoolRewardManager>(arg0),
            coin_type                    : 0x1::type_name::with_defining_ids<T0>(),
            start_time_ms                : arg2,
            end_time_ms                  : arg3,
            total_rewards                : 0x2::balance::value<T0>(&arg1),
            allocated_rewards            : 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(0),
            cumulative_rewards_per_share : 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(0),
            num_position_reward_managers : 0,
            additional_fields            : v0,
        };
        let v3 = find_available_index(arg0);
        assert!(v3 < 50, 0xe0399738759cefcece94a4568f46ddf107abe84aa3a014957ce82adbadfbc785::errors::liquidity_mining_max_concurrent_pool_rewards_violated());
        0x1::option::fill<PoolReward>(0x1::vector::borrow_mut<0x1::option::Option<PoolReward>>(&mut arg0.pool_rewards, v3), v2);
        v3
    }

    public(friend) fun cancel_pool_reward<T0>(arg0: &mut PoolRewardManager, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        update_pool_reward_manager(arg0, arg2);
        let v0 = 0x1::option::borrow_mut<PoolReward>(0x1::vector::borrow_mut<0x1::option::Option<PoolReward>>(&mut arg0.pool_rewards, arg1));
        v0.end_time_ms = 0x2::clock::timestamp_ms(arg2);
        v0.total_rewards = 0;
        let v1 = RewardBalance<T0>{dummy_field: false};
        0x2::balance::split<T0>(0x2::bag::borrow_mut<RewardBalance<T0>, 0x2::balance::Balance<T0>>(&mut v0.additional_fields, v1), 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::floor(0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::sub(0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(v0.total_rewards), v0.allocated_rewards)))
    }

    fun change_position_reward_manager_share(arg0: &mut PoolRewardManager, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) {
        update_position_reward_manager(arg0, arg1, arg3, false);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, PositionRewardManager>(&mut arg0.position_reward_managers, arg1);
        arg0.total_shares = arg0.total_shares - v0.share + arg2;
        v0.share = arg2;
    }

    public(friend) fun claim_rewards<T0>(arg0: &mut PoolRewardManager, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: u64) : 0x2::balance::Balance<T0> {
        update_position_reward_manager(arg0, arg1, arg2, false);
        let v0 = 0x1::option::borrow_mut<PoolReward>(0x1::vector::borrow_mut<0x1::option::Option<PoolReward>>(&mut arg0.pool_rewards, arg3));
        assert!(v0.coin_type == 0x1::type_name::with_defining_ids<T0>(), 0xe0399738759cefcece94a4568f46ddf107abe84aa3a014957ce82adbadfbc785::errors::liquidity_mining_invalid_type());
        let v1 = 0x1::vector::borrow_mut<0x1::option::Option<PositionReward>>(&mut 0x2::table::borrow_mut<0x2::object::ID, PositionRewardManager>(&mut arg0.position_reward_managers, arg1).rewards, arg3);
        assert!(0x1::option::is_some<PositionReward>(v1), 0xe0399738759cefcece94a4568f46ddf107abe84aa3a014957ce82adbadfbc785::errors::liquidity_mining_no_reward_to_claim());
        let v2 = 0x1::option::borrow_mut<PositionReward>(v1);
        let v3 = 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::floor(v2.earned_rewards);
        v2.earned_rewards = 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::sub(v2.earned_rewards, 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(v3));
        if (0x2::clock::timestamp_ms(arg2) >= v0.end_time_ms) {
            let PositionReward {
                pool_reward_id               : _,
                earned_rewards               : _,
                cumulative_rewards_per_share : _,
            } = 0x1::option::extract<PositionReward>(v1);
            v0.num_position_reward_managers = v0.num_position_reward_managers - 1;
        };
        let v7 = RewardBalance<T0>{dummy_field: false};
        0x2::balance::split<T0>(0x2::bag::borrow_mut<RewardBalance<T0>, 0x2::balance::Balance<T0>>(&mut v0.additional_fields, v7), v3)
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
            num_position_reward_managers : v8,
            additional_fields            : v9,
        } = 0x1::option::extract<PoolReward>(0x1::vector::borrow_mut<0x1::option::Option<PoolReward>>(&mut arg0.pool_rewards, arg1));
        let v10 = v9;
        0x2::object::delete(v0);
        assert!(0x2::clock::timestamp_ms(arg2) >= v4, 0xe0399738759cefcece94a4568f46ddf107abe84aa3a014957ce82adbadfbc785::errors::liquidity_mining_pool_reward_period_not_over());
        assert!(v8 == 0, 0xe0399738759cefcece94a4568f46ddf107abe84aa3a014957ce82adbadfbc785::errors::liquidity_mining_not_all_rewards_claimed());
        let v11 = RewardBalance<T0>{dummy_field: false};
        0x2::bag::destroy_empty(v10);
        0x2::bag::remove<RewardBalance<T0>, 0x2::balance::Balance<T0>>(&mut v10, v11)
    }

    public fun coin_type(arg0: &PoolReward) : 0x1::type_name::TypeName {
        arg0.coin_type
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

    public fun last_update_time_ms(arg0: &PositionRewardManager) : u64 {
        arg0.last_update_time_ms
    }

    public(friend) fun new_pool_reward_manager(arg0: &mut 0x2::tx_context::TxContext) : PoolRewardManager {
        PoolRewardManager{
            id                       : 0x2::object::new(arg0),
            total_shares             : 0,
            pool_rewards             : 0x1::vector::empty<0x1::option::Option<PoolReward>>(),
            last_update_time_ms      : 0,
            position_reward_managers : 0x2::table::new<0x2::object::ID, PositionRewardManager>(arg0),
        }
    }

    fun new_position_reward_manager(arg0: &mut PoolRewardManager, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = PositionRewardManager{
            share               : 0,
            rewards             : 0x1::vector::empty<0x1::option::Option<PositionReward>>(),
            last_update_time_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::table::add<0x2::object::ID, PositionRewardManager>(&mut arg0.position_reward_managers, arg1, v0);
        update_position_reward_manager(arg0, arg1, arg2, true);
    }

    public fun num_pool_rewards(arg0: &PoolRewardManager) : u64 {
        0x1::vector::length<0x1::option::Option<PoolReward>>(&arg0.pool_rewards)
    }

    public fun pending_rewards(arg0: &PoolRewardManager, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        if (arg2 >= 0x1::vector::length<0x1::option::Option<PoolReward>>(&arg0.pool_rewards)) {
            return 0
        };
        let v0 = 0x1::vector::borrow<0x1::option::Option<PoolReward>>(&arg0.pool_rewards, arg2);
        if (0x1::option::is_none<PoolReward>(v0)) {
            return 0
        };
        let v1 = 0x1::option::borrow<PoolReward>(v0);
        if (!0x2::table::contains<0x2::object::ID, PositionRewardManager>(&arg0.position_reward_managers, arg1)) {
            return 0
        };
        let v2 = 0x2::table::borrow<0x2::object::ID, PositionRewardManager>(&arg0.position_reward_managers, arg1);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = v1.cumulative_rewards_per_share;
        let v5 = v4;
        let v6 = if (arg0.total_shares > 0) {
            if (v3 > arg0.last_update_time_ms) {
                if (v3 > v1.start_time_ms) {
                    arg0.last_update_time_ms < v1.end_time_ms
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v6) {
            v5 = 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::add(v4, 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::div(0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::mul(0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::div(0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(v1.total_rewards), 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(v1.end_time_ms - v1.start_time_ms)), 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(0x1::u64::min(v3, v1.end_time_ms) - 0x1::u64::max(v1.start_time_ms, arg0.last_update_time_ms))), 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(arg0.total_shares)));
        };
        if (arg2 < 0x1::vector::length<0x1::option::Option<PositionReward>>(&v2.rewards) && 0x1::option::is_some<PositionReward>(0x1::vector::borrow<0x1::option::Option<PositionReward>>(&v2.rewards, arg2))) {
            let v8 = 0x1::option::borrow<PositionReward>(0x1::vector::borrow<0x1::option::Option<PositionReward>>(&v2.rewards, arg2));
            0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::floor(0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::add(v8.earned_rewards, 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::mul(0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::sub(v5, v8.cumulative_rewards_per_share), 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(v2.share))))
        } else if (v2.last_update_time_ms <= v1.start_time_ms) {
            0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::floor(0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::mul(v5, 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(v2.share)))
        } else {
            0
        }
    }

    public fun pool_reward(arg0: &PoolRewardManager, arg1: u64) : &0x1::option::Option<PoolReward> {
        0x1::vector::borrow<0x1::option::Option<PoolReward>>(&arg0.pool_rewards, arg1)
    }

    public fun pool_reward_id(arg0: &PoolRewardManager, arg1: u64) : 0x2::object::ID {
        0x2::object::id<PoolReward>(0x1::option::borrow<PoolReward>(0x1::vector::borrow<0x1::option::Option<PoolReward>>(&arg0.pool_rewards, arg1)))
    }

    public fun position_reward_manager(arg0: &PoolRewardManager, arg1: 0x2::object::ID) : &PositionRewardManager {
        0x2::table::borrow<0x2::object::ID, PositionRewardManager>(&arg0.position_reward_managers, arg1)
    }

    public fun position_share(arg0: &PoolRewardManager, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, PositionRewardManager>(&arg0.position_reward_managers, arg1)) {
            0x2::table::borrow<0x2::object::ID, PositionRewardManager>(&arg0.position_reward_managers, arg1).share
        } else {
            0
        }
    }

    public(friend) fun remove_position_reward_manager(arg0: &mut PoolRewardManager, arg1: 0x2::object::ID) {
        let PositionRewardManager {
            share               : v0,
            rewards             : v1,
            last_update_time_ms : _,
        } = 0x2::table::remove<0x2::object::ID, PositionRewardManager>(&mut arg0.position_reward_managers, arg1);
        let v3 = v1;
        assert!(v0 == 0, 0xe0399738759cefcece94a4568f46ddf107abe84aa3a014957ce82adbadfbc785::errors::liquidity_mining_share_not_zero());
        while (!0x1::vector::is_empty<0x1::option::Option<PositionReward>>(&v3)) {
            let v4 = 0x1::vector::pop_back<0x1::option::Option<PositionReward>>(&mut v3);
            assert!(0x1::option::is_none<PositionReward>(&v4), 0xe0399738759cefcece94a4568f46ddf107abe84aa3a014957ce82adbadfbc785::errors::liquidity_mining_not_all_rewards_claimed());
            0x1::option::destroy_none<PositionReward>(v4);
        };
        0x1::vector::destroy_empty<0x1::option::Option<PositionReward>>(v3);
    }

    public(friend) fun set_position_share(arg0: &mut PoolRewardManager, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) {
        if (!0x2::table::contains<0x2::object::ID, PositionRewardManager>(&arg0.position_reward_managers, arg1)) {
            new_position_reward_manager(arg0, arg1, arg3);
        };
        change_position_reward_manager_share(arg0, arg1, arg2, arg3);
    }

    public fun shares(arg0: &PositionRewardManager) : u64 {
        arg0.share
    }

    public fun start_time_ms(arg0: &PoolReward) : u64 {
        arg0.start_time_ms
    }

    public fun total_rewards(arg0: &PoolReward) : u64 {
        arg0.total_rewards
    }

    public fun total_shares(arg0: &PoolRewardManager) : u64 {
        arg0.total_shares
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
            let v4 = 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::mul(0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::div(0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(v3.total_rewards), 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(v3.end_time_ms - v3.start_time_ms)), 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(0x1::u64::min(v0, v3.end_time_ms) - 0x1::u64::max(v3.start_time_ms, arg0.last_update_time_ms)));
            v3.allocated_rewards = 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::add(v3.allocated_rewards, v4);
            v3.cumulative_rewards_per_share = 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::add(v3.cumulative_rewards_per_share, 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::div(v4, 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(arg0.total_shares)));
            v1 = v1 + 1;
        };
        arg0.last_update_time_ms = v0;
    }

    fun update_position_reward_manager(arg0: &mut PoolRewardManager, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: bool) {
        update_pool_reward_manager(arg0, arg2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, PositionRewardManager>(&mut arg0.position_reward_managers, arg1);
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
            while (0x1::vector::length<0x1::option::Option<PositionReward>>(&v0.rewards) <= v2) {
                0x1::vector::push_back<0x1::option::Option<PositionReward>>(&mut v0.rewards, 0x1::option::none<PositionReward>());
            };
            let v5 = 0x1::vector::borrow_mut<0x1::option::Option<PositionReward>>(&mut v0.rewards, v2);
            if (0x1::option::is_none<PositionReward>(v5)) {
                if (v0.last_update_time_ms <= v4.end_time_ms) {
                    let v6 = if (v0.last_update_time_ms <= v4.start_time_ms) {
                        0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::mul(v4.cumulative_rewards_per_share, 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(v0.share))
                    } else {
                        0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(0)
                    };
                    let v7 = PositionReward{
                        pool_reward_id               : 0x2::object::id<PoolReward>(v4),
                        earned_rewards               : v6,
                        cumulative_rewards_per_share : v4.cumulative_rewards_per_share,
                    };
                    0x1::option::fill<PositionReward>(v5, v7);
                    v4.num_position_reward_managers = v4.num_position_reward_managers + 1;
                };
            } else {
                let v8 = 0x1::option::borrow_mut<PositionReward>(v5);
                v8.earned_rewards = 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::add(v8.earned_rewards, 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::mul(0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::sub(v4.cumulative_rewards_per_share, v8.cumulative_rewards_per_share), 0xeb1676ce24dbfa9d48d528ee807b654a1a0785ededa0e36b9d829db971bb664c::float::from(v0.share)));
                v8.cumulative_rewards_per_share = v4.cumulative_rewards_per_share;
            };
            v2 = v2 + 1;
        };
        v0.last_update_time_ms = v1;
    }

    // decompiled from Move bytecode v6
}

