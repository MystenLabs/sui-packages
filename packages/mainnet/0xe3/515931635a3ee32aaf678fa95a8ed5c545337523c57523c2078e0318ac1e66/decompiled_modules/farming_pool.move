module 0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::farming_pool {
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

    public fun add_reward_pool<T0: drop, T1: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: &mut 0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::MarketState<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg7), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::add_reward_pool_role()), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::acl_invalid_permission());
        assert!(0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::market_expiry<T0>(arg2) > 0x2::clock::timestamp_ms(arg6), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::market_expired());
        assert!(0x2::coin::value<T1>(&arg4) > 0, 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::invalid_reward_amount());
        assert!(arg5 > 0x2::clock::timestamp_ms(arg6) && arg5 <= 0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::market_expiry<T0>(arg2), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::invalid_reward_end_time());
        assert!((arg5 - 0x2::clock::timestamp_ms(arg6)) / 1000 * arg3 <= 0x2::coin::value<T1>(&arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::emission_exceeds_total_reward());
        let v0 = 0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::farming_reward::add_rewarder<T1>(0x1::type_name::get<T1>(), 0x2::coin::split<T1>(&mut arg4, (arg5 - 0x2::clock::timestamp_ms(arg6)) / 1000 * arg3, arg7), arg3, arg5, 0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::market_reward_pool<T0>(arg2), arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, 0x2::tx_context::sender(arg7));
        let v1 = PoolRewarderAddEvent{
            market_state_id     : 0x2::object::id<0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::MarketState<T0>>(arg2),
            pool_reward_id      : v0,
            reward_token        : 0x1::type_name::get<T1>(),
            emission_per_second : arg3,
            amount              : 0x2::coin::value<T1>(&arg4),
            end_time            : arg5,
        };
        0x2::event::emit<PoolRewarderAddEvent>(v1);
        v0
    }

    public fun add_reward_pool_total_reward<T0: drop, T1: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg8), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::add_reward_pool_role()), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::acl_invalid_permission());
        assert!(0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::market_expiry<T0>(arg6) > 0x2::clock::timestamp_ms(arg7), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::market_expired());
        assert!(0x2::coin::value<T1>(&arg5) > 0, 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::invalid_reward_amount());
        assert!(arg4 > 0x2::clock::timestamp_ms(arg7) && arg4 <= 0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::market_expiry<T0>(arg6), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::invalid_reward_end_time());
        0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::farming_reward::update_rewarder<T1>(0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::market_reward_pool<T0>(arg6), arg2, arg3, arg4, arg5, arg7, arg8);
        let v0 = PoolRewarderUpdateEvent{
            market_state_id     : 0x2::object::id<0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::MarketState<T0>>(arg6),
            pool_reward_id      : arg2,
            emission_per_second : arg3,
            amount              : 0x2::coin::value<T1>(&arg5),
            end_time            : arg4,
        };
        0x2::event::emit<PoolRewarderUpdateEvent>(v0);
    }

    public fun emergent_stop_pool_rewarder<T0: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::MarketState<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::add_reward_pool_role()), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::acl_invalid_permission());
        0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::farming_reward::stop_rewarder(0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::market_reward_pool<T0>(arg3), arg2, arg4);
        let v0 = PoolRewarderStopEvent{
            market_state_id : 0x2::object::id<0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
        };
        0x2::event::emit<PoolRewarderStopEvent>(v0);
    }

    public fun emergent_withdraw_pool_rewarder<T0: drop, T1: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::MarketState<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg5), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::acl_invalid_permission());
        let v0 = PoolRewarderWithdrawEvent{
            market_state_id : 0x2::object::id<0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
            amount          : 0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::farming_reward::emergency_withdraw_rewarder<T1>(0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::market_reward_pool<T0>(arg3), arg2, arg4, arg5),
        };
        0x2::event::emit<PoolRewarderWithdrawEvent>(v0);
    }

    public fun enable_pool_rewarder<T0: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::MarketState<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::add_reward_pool_role()), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::acl_invalid_permission());
        0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::farming_reward::enable_rewarder(0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::market_reward_pool<T0>(arg3), arg2, arg4);
        let v0 = PoolRewarderEnableEvent{
            market_state_id : 0x2::object::id<0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
        };
        0x2::event::emit<PoolRewarderEnableEvent>(v0);
    }

    public fun remove_reward_pool<T0: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::MarketState<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::admin_role()), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::acl_invalid_permission());
        0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::farming_reward::remove_rewarder(0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::market_reward_pool<T0>(arg3), arg2);
        let v0 = PoolRewarderRemoveEvent{
            market_state_id : 0x2::object::id<0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
        };
        0x2::event::emit<PoolRewarderRemoveEvent>(v0);
    }

    public fun supplement_addtional_reward_token<T0: drop, T1: drop>(arg0: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::Version, arg1: &0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::ACL, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: &mut 0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::version::assert_current_version(arg0);
        assert!(0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::has_role(arg1, 0x2::tx_context::sender(arg6), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::acl::add_reward_pool_role()), 0xe02f3a5e3f585b445a1b6af49361d813af747deef95e587db81caa1ff71ce914::error::acl_invalid_permission());
        0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::farming_reward::supplement_additional_reward_token<T1>(0xe3515931635a3ee32aaf678fa95a8ed5c545337523c57523c2078e0318ac1e66::market::market_reward_pool<T0>(arg4), arg3, arg2, arg5);
    }

    // decompiled from Move bytecode v6
}

