module 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::farming_pool {
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

    public fun add_reward_pool<T0: drop, T1: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::MarketState<T0>, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg7), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::add_reward_pool_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::acl_invalid_permission());
        assert!(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::market_expiry<T0>(arg2) > 0x2::clock::timestamp_ms(arg6), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_expired());
        assert!(0x2::coin::value<T1>(&arg4) > 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::invalid_reward_amount());
        assert!(arg5 > 0x2::clock::timestamp_ms(arg6) && arg5 <= 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::market_expiry<T0>(arg2), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::invalid_reward_end_time());
        assert!((arg5 - 0x2::clock::timestamp_ms(arg6)) / 1000 * arg3 <= 0x2::coin::value<T1>(&arg4), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::emission_exceeds_total_reward());
        let v0 = 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::farming_reward::add_rewarder<T1>(0x1::type_name::with_defining_ids<T1>(), 0x2::coin::split<T1>(&mut arg4, (arg5 - 0x2::clock::timestamp_ms(arg6)) / 1000 * arg3, arg7), arg3, arg5, 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::market_reward_pool<T0>(arg2), arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, 0x2::tx_context::sender(arg7));
        let v1 = PoolRewarderAddEvent{
            market_state_id     : 0x2::object::id<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::MarketState<T0>>(arg2),
            pool_reward_id      : v0,
            reward_token        : 0x1::type_name::with_defining_ids<T1>(),
            emission_per_second : arg3,
            amount              : 0x2::coin::value<T1>(&arg4),
            end_time            : arg5,
        };
        0x2::event::emit<PoolRewarderAddEvent>(v1);
        v0
    }

    public fun emergent_stop_pool_rewarder<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::MarketState<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::add_reward_pool_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::acl_invalid_permission());
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::farming_reward::stop_rewarder(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::market_reward_pool<T0>(arg3), arg2, arg4);
        let v0 = PoolRewarderStopEvent{
            market_state_id : 0x2::object::id<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
        };
        0x2::event::emit<PoolRewarderStopEvent>(v0);
    }

    public fun emergent_withdraw_pool_rewarder<T0: drop, T1: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::MarketState<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg5), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::acl_invalid_permission());
        let v0 = PoolRewarderWithdrawEvent{
            market_state_id : 0x2::object::id<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
            amount          : 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::farming_reward::emergency_withdraw_rewarder<T1>(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::market_reward_pool<T0>(arg3), arg2, arg4, arg5),
        };
        0x2::event::emit<PoolRewarderWithdrawEvent>(v0);
    }

    public fun enable_pool_rewarder<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::MarketState<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::add_reward_pool_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::acl_invalid_permission());
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::farming_reward::enable_rewarder(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::market_reward_pool<T0>(arg3), arg2, arg4);
        let v0 = PoolRewarderEnableEvent{
            market_state_id : 0x2::object::id<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
        };
        0x2::event::emit<PoolRewarderEnableEvent>(v0);
    }

    public fun remove_reward_pool<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: 0x2::object::ID, arg3: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::MarketState<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::acl_invalid_permission());
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::farming_reward::remove_rewarder(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::market_reward_pool<T0>(arg3), arg2);
        let v0 = PoolRewarderRemoveEvent{
            market_state_id : 0x2::object::id<0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::MarketState<T0>>(arg3),
            pool_reward_id  : arg2,
        };
        0x2::event::emit<PoolRewarderRemoveEvent>(v0);
    }

    public fun supplement_addtional_reward_token<T0: drop, T1: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: &mut 0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::MarketState<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg6), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::add_reward_pool_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::acl_invalid_permission());
        assert!(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::market_expiry<T0>(arg4) > 0x2::clock::timestamp_ms(arg5), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::market_expired());
        assert!(0x2::coin::value<T1>(&arg2) > 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::invalid_reward_amount());
        0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::farming_reward::supplement_additional_reward_token<T1>(0x4a7e41fa845732496c7c7eb7665ef0badac752d7ca7dc4428802553ade792337::market::market_reward_pool<T0>(arg4), arg3, arg2, arg5);
    }

    // decompiled from Move bytecode v6
}

