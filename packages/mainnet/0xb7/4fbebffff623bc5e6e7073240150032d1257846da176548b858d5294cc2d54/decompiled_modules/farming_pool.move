module 0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::farming_pool {
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

    public fun add_reward_pool<T0: drop, T1: drop>(arg0: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::Version, arg1: &0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::ACL, arg2: &mut 0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market::MarketState<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::version::assert_current_version(arg0);
        assert!(0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::has_role(arg1, 0x2::tx_context::sender(arg7), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::acl::add_reward_pool_role()), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::acl_invalid_permission());
        assert!(0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market::market_expiry<T0>(arg2) > 0x2::clock::timestamp_ms(arg6), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::market_expired());
        assert!(0x2::coin::value<T1>(&arg4) > 0, 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::invalid_reward_amount());
        assert!(arg5 > 0x2::clock::timestamp_ms(arg6) && arg5 <= 0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market::market_expiry<T0>(arg2), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::invalid_reward_end_time());
        assert!((arg5 - 0x2::clock::timestamp_ms(arg6)) / 1000 * arg3 <= 0x2::coin::value<T1>(&arg4), 0xc42c2c2503a8a1ad3f20e351b958d30aaba8635d21c2fe0e858ed4834314df9::error::emission_exceeds_total_reward());
        let v0 = 0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::farming_reward::add_rewarder<T1>(0x1::type_name::with_defining_ids<T1>(), 0x2::coin::split<T1>(&mut arg4, (arg5 - 0x2::clock::timestamp_ms(arg6)) / 1000 * arg3, arg7), arg3, arg5, 0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market::market_reward_pool<T0>(arg2), arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, 0x2::tx_context::sender(arg7));
        let v1 = PoolRewarderAddEvent{
            market_state_id     : 0x2::object::id<0xb74fbebffff623bc5e6e7073240150032d1257846da176548b858d5294cc2d54::market::MarketState<T0>>(arg2),
            pool_reward_id      : v0,
            reward_token        : 0x1::type_name::with_defining_ids<T1>(),
            emission_per_second : arg3,
            amount              : 0x2::coin::value<T1>(&arg4),
            end_time            : arg5,
        };
        0x2::event::emit<PoolRewarderAddEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

