module 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::farming_pool {
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

    public fun add_reward_pool<T0: drop, T1: drop>(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::ACL, arg2: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::MarketState<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        assert!(0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::has_role(arg1, 0x2::tx_context::sender(arg7), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::add_reward_pool_role()), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::acl_invalid_permission());
        assert!(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::market_expiry<T0>(arg2) > 0x2::clock::timestamp_ms(arg6), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::market_expired());
        assert!(0x2::coin::value<T1>(&arg4) > 0, 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::invalid_reward_amount());
        assert!(arg5 > 0x2::clock::timestamp_ms(arg6) && arg5 <= 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::market_expiry<T0>(arg2), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::invalid_reward_end_time());
        assert!((arg5 - 0x2::clock::timestamp_ms(arg6)) / 1000 * arg3 <= 0x2::coin::value<T1>(&arg4), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::emission_exceeds_total_reward());
        let v0 = 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::farming_reward::add_rewarder<T1>(0x1::type_name::get<T1>(), 0x2::coin::split<T1>(&mut arg4, (arg5 - 0x2::clock::timestamp_ms(arg6)) / 1000 * arg3, arg7), arg3, arg5, 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::market_reward_pool<T0>(arg2), arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, 0x2::tx_context::sender(arg7));
        let v1 = PoolRewarderAddEvent{
            market_state_id     : 0x2::object::id<0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::MarketState<T0>>(arg2),
            pool_reward_id      : v0,
            reward_token        : 0x1::type_name::get<T1>(),
            emission_per_second : arg3,
            amount              : 0x2::coin::value<T1>(&arg4),
            end_time            : arg5,
        };
        0x2::event::emit<PoolRewarderAddEvent>(v1);
        v0
    }

    public fun add_reward_pool_total_reward<T0: drop, T1: drop>(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::ACL, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::MarketState<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        assert!(0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::has_role(arg1, 0x2::tx_context::sender(arg8), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::add_reward_pool_role()), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::acl_invalid_permission());
        assert!(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::market_expiry<T0>(arg6) > 0x2::clock::timestamp_ms(arg7), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::market_expired());
        assert!(0x2::coin::value<T1>(&arg5) > 0, 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::invalid_reward_amount());
        assert!(arg4 > 0x2::clock::timestamp_ms(arg7) && arg4 <= 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::market_expiry<T0>(arg6), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::invalid_reward_end_time());
        0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::farming_reward::update_rewarder<T1>(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::market_reward_pool<T0>(arg6), arg2, arg3, arg4, arg5, arg7, arg8);
        let v0 = PoolRewarderUpdateEvent{
            market_state_id     : 0x2::object::id<0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::MarketState<T0>>(arg6),
            pool_reward_id      : arg2,
            emission_per_second : arg3,
            amount              : 0x2::coin::value<T1>(&arg5),
            end_time            : arg4,
        };
        0x2::event::emit<PoolRewarderUpdateEvent>(v0);
    }

    public fun emergent_stop_pool_rewarder<T0: drop>(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::MarketState<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        assert!(0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::add_reward_pool_role()), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::acl_invalid_permission());
        0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::farming_reward::stop_rewarder(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::market_reward_pool<T0>(arg3), arg2, arg4);
        let v0 = PoolRewarderStopEvent{
            market_state_id : 0x2::object::id<0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
        };
        0x2::event::emit<PoolRewarderStopEvent>(v0);
    }

    public fun emergent_withdraw_pool_rewarder<T0: drop, T1: drop>(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::MarketState<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        assert!(0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::has_role(arg1, 0x2::tx_context::sender(arg5), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::admin_role()), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::acl_invalid_permission());
        let v0 = PoolRewarderWithdrawEvent{
            market_state_id : 0x2::object::id<0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
            amount          : 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::farming_reward::emergency_withdraw_rewarder<T1>(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::market_reward_pool<T0>(arg3), arg2, arg4, arg5),
        };
        0x2::event::emit<PoolRewarderWithdrawEvent>(v0);
    }

    public fun enable_pool_rewarder<T0: drop>(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::MarketState<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        assert!(0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::add_reward_pool_role()), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::acl_invalid_permission());
        0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::farming_reward::enable_rewarder(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::market_reward_pool<T0>(arg3), arg2, arg4);
        let v0 = PoolRewarderEnableEvent{
            market_state_id : 0x2::object::id<0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
        };
        0x2::event::emit<PoolRewarderEnableEvent>(v0);
    }

    public fun remove_reward_pool<T0: drop>(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::MarketState<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        assert!(0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::admin_role()), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::acl_invalid_permission());
        0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::farming_reward::remove_rewarder(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::market_reward_pool<T0>(arg3), arg2);
        let v0 = PoolRewarderRemoveEvent{
            market_state_id : 0x2::object::id<0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
        };
        0x2::event::emit<PoolRewarderRemoveEvent>(v0);
    }

    public fun supplement_addtional_reward_token<T0: drop, T1: drop>(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::ACL, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: &mut 0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        assert!(0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::has_role(arg1, 0x2::tx_context::sender(arg6), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::add_reward_pool_role()), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::acl_invalid_permission());
        0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::farming_reward::supplement_additional_reward_token<T1>(0x698d898c1994b871001867c3dd80aabef9094ae6350801723677f337b6cd54dc::market::market_reward_pool<T0>(arg4), arg3, arg2, arg5);
    }

    // decompiled from Move bytecode v6
}

