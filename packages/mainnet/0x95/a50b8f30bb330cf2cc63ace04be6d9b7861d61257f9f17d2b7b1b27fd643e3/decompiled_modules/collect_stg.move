module 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::collect_stg {
    struct CollectFeesEvent has copy, drop {
        vault_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        sender: address,
    }

    struct CollectRewardEvent has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
    }

    public fun fees<T0, T1, T2>(arg0: &mut 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::Vault<T0, T1, T2>, arg1: &mut 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::pool::Pool<T0, T1>, arg2: &0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::Version, arg3: &0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::assert_current_version(arg2);
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        let (v0, v1) = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::collect::fee<T0, T1>(arg1, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::position_borrow_mut<T0, T1, T2>(arg0), arg4, arg3, arg5);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = CollectFeesEvent{
            vault_id : 0x2::object::id<0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::Vault<T0, T1, T2>>(arg0),
            amount_a : 0x2::balance::value<T0>(&v2),
            amount_b : 0x2::balance::value<T1>(&v3),
            sender   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CollectFeesEvent>(v4);
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::add_free_balance_a<T0, T1, T2>(arg0, v2);
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::add_free_balance_b<T0, T1, T2>(arg0, v3);
    }

    public fun rewards<T0, T1, T2, T3>(arg0: &mut 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::Vault<T0, T1, T2>, arg1: &mut 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::pool::Pool<T0, T1>, arg2: &0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::Version, arg3: &0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::assert_current_version(arg2);
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T3>(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::collect::reward<T0, T1, T3>(arg1, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::position_borrow_mut<T0, T1, T2>(arg0), arg4, arg3, arg5));
        let v1 = CollectRewardEvent{
            vault_id    : 0x2::object::id<0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::Vault<T0, T1, T2>>(arg0),
            reward_type : 0x1::type_name::get<T3>(),
            amount      : 0x2::balance::value<T3>(&v0),
            sender      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CollectRewardEvent>(v1);
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::add_reward<T0, T1, T2, T3>(arg0, v0);
    }

    public fun rewards_x<T0, T1, T2>(arg0: &mut 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::Vault<T0, T1, T2>, arg1: &mut 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::pool::Pool<T0, T1>, arg2: &0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::Version, arg3: &0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::assert_current_version(arg2);
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T0>(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::collect::reward<T0, T1, T0>(arg1, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::position_borrow_mut<T0, T1, T2>(arg0), arg4, arg3, arg5));
        let v1 = CollectRewardEvent{
            vault_id    : 0x2::object::id<0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::Vault<T0, T1, T2>>(arg0),
            reward_type : 0x1::type_name::get<T0>(),
            amount      : 0x2::balance::value<T0>(&v0),
            sender      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CollectRewardEvent>(v1);
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::add_reward_x<T0, T1, T2>(arg0, v0);
    }

    public fun rewards_y<T0, T1, T2>(arg0: &mut 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::Vault<T0, T1, T2>, arg1: &mut 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::pool::Pool<T0, T1>, arg2: &0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::Version, arg3: &0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::version_stg::assert_current_version(arg2);
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::check_pool_compatibility<T0, T1, T2>(arg0, arg1);
        let v0 = 0x2::coin::into_balance<T1>(0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::collect::reward<T0, T1, T1>(arg1, 0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::position_borrow_mut<T0, T1, T2>(arg0), arg4, arg3, arg5));
        let v1 = CollectRewardEvent{
            vault_id    : 0x2::object::id<0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::Vault<T0, T1, T2>>(arg0),
            reward_type : 0x1::type_name::get<T1>(),
            amount      : 0x2::balance::value<T1>(&v0),
            sender      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<CollectRewardEvent>(v1);
        0x62cd0678e86bc9afaf8d9a78ef0e9185409838997d3bce87e3a5b49aee67dff4::vault_stg::add_reward_y<T0, T1, T2>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

