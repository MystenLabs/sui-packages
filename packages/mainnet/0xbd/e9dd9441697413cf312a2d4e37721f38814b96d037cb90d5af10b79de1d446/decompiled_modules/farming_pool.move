module 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::farming_pool {
    struct PoolRewarderAddEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        pool_reward_id: 0x2::object::ID,
        reward_token: 0x1::type_name::TypeName,
        emission_per_second: u64,
        amount: u64,
        end_time: u64,
    }

    struct PoolRewarderRemoveEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        pool_reward_id: 0x2::object::ID,
    }

    struct PoolRewarderStopEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        pool_reward_id: 0x2::object::ID,
    }

    struct PoolRewarderEnableEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        pool_reward_id: 0x2::object::ID,
    }

    struct PoolRewarderWithdrawEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        pool_reward_id: 0x2::object::ID,
        amount: u64,
    }

    struct PoolRewarderUpdateEvent has copy, drop {
        market_state_id: 0x2::object::ID,
        pool_reward_id: 0x2::object::ID,
        emission_per_second: u64,
        amount: u64,
        end_time: u64,
    }

    public fun add_reward_pool<T0: drop, T1: drop>(arg0: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::Version, arg1: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::ACL, arg2: &mut 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::MarketState<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::assert_current_version(arg0);
        assert!(0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::has_role(arg1, 0x2::tx_context::sender(arg7), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::add_reward_pool_role()), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::acl_invalid_permission());
        assert!(0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::market_expiry<T0>(arg2) > 0x2::clock::timestamp_ms(arg6), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::market_expired());
        assert!(0x2::coin::value<T1>(&arg4) > 0, 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::invalid_reward_amount());
        assert!(arg5 > 0x2::clock::timestamp_ms(arg6) && arg5 <= 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::market_expiry<T0>(arg2), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::invalid_reward_end_time());
        assert!((arg5 - 0x2::clock::timestamp_ms(arg6)) / 1000 * arg3 <= 0x2::coin::value<T1>(&arg4), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::emission_exceeds_total_reward());
        let v0 = 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::farming_reward::add_rewarder<T1>(arg7, 0x1::type_name::get<T1>(), 0x2::coin::split<T1>(&mut arg4, (arg5 - 0x2::clock::timestamp_ms(arg6)) / 1000 * arg3, arg7), arg3, arg5, 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::market_reward_pool<T0>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, 0x2::tx_context::sender(arg7));
        let v1 = PoolRewarderAddEvent{
            market_state_id     : 0x2::object::id<0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::MarketState<T0>>(arg2),
            pool_reward_id      : v0,
            reward_token        : 0x1::type_name::get<T1>(),
            emission_per_second : arg3,
            amount              : 0x2::coin::value<T1>(&arg4),
            end_time            : arg5,
        };
        0x2::event::emit<PoolRewarderAddEvent>(v1);
        v0
    }

    public fun add_reward_pool_total_reward<T0: drop, T1: drop>(arg0: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::Version, arg1: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::ACL, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::assert_current_version(arg0);
        assert!(0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::has_role(arg1, 0x2::tx_context::sender(arg8), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::add_reward_pool_role()), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::acl_invalid_permission());
        assert!(0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::market_expiry<T0>(arg6) > 0x2::clock::timestamp_ms(arg7), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::market_expired());
        assert!(0x2::coin::value<T1>(&arg5) > 0, 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::invalid_reward_amount());
        assert!(arg4 > 0x2::clock::timestamp_ms(arg7) && arg4 <= 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::market_expiry<T0>(arg6), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::invalid_reward_end_time());
        assert!((arg4 - 0x2::clock::timestamp_ms(arg7)) / 1000 * arg3 <= 0x2::coin::value<T1>(&arg5), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::emission_exceeds_total_reward());
        0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::farming_reward::update_rewarder<T1>(arg8, 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::market_reward_pool<T0>(arg6), arg2, arg3, arg4, arg5, arg7);
        let v0 = PoolRewarderUpdateEvent{
            market_state_id     : 0x2::object::id<0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::MarketState<T0>>(arg6),
            pool_reward_id      : arg2,
            emission_per_second : arg3,
            amount              : 0x2::coin::value<T1>(&arg5),
            end_time            : arg4,
        };
        0x2::event::emit<PoolRewarderUpdateEvent>(v0);
    }

    public fun emergent_stop_pool_rewarder<T0: drop>(arg0: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::Version, arg1: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::MarketState<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::assert_current_version(arg0);
        assert!(0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::add_reward_pool_role()), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::acl_invalid_permission());
        0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::farming_reward::stop_rewarder(arg4, 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::market_reward_pool<T0>(arg3), arg2);
        let v0 = PoolRewarderStopEvent{
            market_state_id : 0x2::object::id<0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
        };
        0x2::event::emit<PoolRewarderStopEvent>(v0);
    }

    public fun emergent_withdraw_pool_rewarder<T0: drop, T1: drop>(arg0: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::Version, arg1: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::MarketState<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::assert_current_version(arg0);
        assert!(0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::has_role(arg1, 0x2::tx_context::sender(arg5), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::admin_role()), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::acl_invalid_permission());
        let v0 = PoolRewarderWithdrawEvent{
            market_state_id : 0x2::object::id<0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
            amount          : 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::farming_reward::emergency_withdraw_rewarder<T1>(arg5, 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::market_reward_pool<T0>(arg3), arg2, arg4),
        };
        0x2::event::emit<PoolRewarderWithdrawEvent>(v0);
    }

    public fun enable_pool_rewarder<T0: drop>(arg0: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::Version, arg1: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::MarketState<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::assert_current_version(arg0);
        assert!(0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::add_reward_pool_role()), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::acl_invalid_permission());
        0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::farming_reward::enable_rewarder(arg4, 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::market_reward_pool<T0>(arg3), arg2);
        let v0 = PoolRewarderEnableEvent{
            market_state_id : 0x2::object::id<0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
        };
        0x2::event::emit<PoolRewarderEnableEvent>(v0);
    }

    public fun remove_reward_pool<T0: drop>(arg0: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::Version, arg1: &0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::MarketState<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::version::assert_current_version(arg0);
        assert!(0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::acl::admin_role()), 0x27e34c965f1c71c02050646f627ab46dfc49095f9e448f310ca1a03c1becbfac::error::acl_invalid_permission());
        0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::farming_reward::remove_rewarder(0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::market_reward_pool<T0>(arg3), arg2);
        let v0 = PoolRewarderRemoveEvent{
            market_state_id : 0x2::object::id<0xbde9dd9441697413cf312a2d4e37721f38814b96d037cb90d5af10b79de1d446::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
        };
        0x2::event::emit<PoolRewarderRemoveEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

